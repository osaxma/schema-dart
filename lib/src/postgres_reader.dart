import 'package:postgres/postgres.dart';

import 'logger.dart';
import 'types.dart';

class PostgresReader {
  late final PostgreSQLConnection _connection;

  final String host;
  final String databaseName;
  final int port;
  final String? username;
  final String? password;
  final Duration timeout;
  final Duration queryTimeout;

  PostgresReader({
    required this.host,
    required this.databaseName,
    required this.port,
    this.username,
    this.password,
    this.timeout = const Duration(seconds: 30),
    this.queryTimeout = const Duration(seconds: 30),
  });

  factory PostgresReader.fromConnectionString(
    String connectionString, {
    Duration timeout = const Duration(seconds: 30),
    Duration queryTimeout = const Duration(seconds: 30),
  }) {
    // expected format: postgresql://<username>:<password>@<host>:<port>/<database-name>
    connectionString = connectionString.trim();
    if (!connectionString.startsWith('postgresql://')) {
      throw FormatException('The provided connection string does not start with `postgresql://`'
          '\nconnectionString = $connectionString');
    }

    // from: postgresql://<username>:<password>@<host>:<port>/<database-name>
    // to:  <username>:<password>@<host>:<port>/<database-name>
    connectionString = connectionString.replaceAll('postgresql://', '');

    // from:   <username>:<password>@<host>:<port>/<database-name>
    // to:     ['username', 'password', 'host', 'port', 'databaseName']
    final parts = connectionString.split(RegExp(r':|@|\/'));

    if (parts.length < 5) {
      throw FormatException('Could not find all five required values:\n'
          'username, password, host, port, databaseName.\n'
          'make sure the connection string is formatted as follow:\n'
          'postgresql://<username>:<password>@<host>:<port>/<database-name>');
    }

    final username = parts[0];
    final password = parts[1];
    final host = parts[2];

    if (int.tryParse(parts[3]) == null) {
      throw FormatException('The port is not formatted correctly, expected an `integer` but got ${parts[3]}');
    }
    final port = int.parse(parts[3]);
    final databaseName = parts[4];

    return PostgresReader(
      username: username,
      password: password,
      host: host,
      port: port,
      databaseName: databaseName,
      timeout: timeout,
      queryTimeout: queryTimeout,
    );
  }

  Future<void> connect() async {
    _connection = PostgreSQLConnection(
      host,
      port,
      databaseName,
      username: username,
      password: password,
      timeoutInSeconds: timeout.inSeconds,
      queryTimeoutInSeconds: queryTimeout.inSeconds,
    );
    await _connection.open();
  }

  /// Retrieve the postgres schemas
  ///
  /// Provide [schemaNames] to retrieve data for specific schema only,
  /// an empty list (default) indicates all schemas excluding `pg_toast`, `pg_catalog` and `information_schema`.
  Future<List<String>> getSchemas({
    List<String>? schemaNames,
  }) async {
    schemaNames ??= const <String>[];
    final rawQuery = _buildSchemasQuery(schemaNames: schemaNames);

    Log.trace('executing the following query:\n$rawQuery');

    final res = await _connection.mappedResultsQuery(rawQuery);

    final schemas = <String>[];

    final resultKey = "";

    for (final row in res) {
      final result = row[resultKey];
      final schemaName = result?["schema_name"];
      if (schemas.isEmpty || schemaName != schemas.last) {
        Log.trace('reading schema: $schemaName');
        schemas.add(schemaName);
      }
    }

    return schemas;
  }

  String _buildSchemasQuery({
    required List<String> schemaNames,
  }) {
    String rawQuery = '''
        select schema_name
        from information_schema.schemata
        where schema_name not in ('pg_toast', 'pg_catalog', 'information_schema') 
    ''';

    if (schemaNames.length == 1) {
      rawQuery += "and schema_name = '${schemaNames[0]}';";
    } else if (schemaNames.length > 1) {
      rawQuery +=
          'and schema_name in (' + schemaNames.reduce((s1, s2) => s1.startsWith("'") ? "$s1, '$s2'" : "'$s1', '$s2'") + ');';
    } else {
      rawQuery += ';';
    }

    return rawQuery;
  }

  /// Retrieve the postgres type for all columns
  ///
  /// The [schemaNames] defaults to [`public`].
  /// Provide [tableNames] to retrieve data for specific tables only,
  /// an empty list (default) indicates all tables.
  Future<List<Table>> getTables({
    List<String> schemaNames = const ['public'],
    List<String>? tableNames,
  }) async {
    tableNames ??= const <String>[];
    final rawQuery = _buildColumnTypesQuery(tableNames: tableNames, schemaNames: schemaNames);

    Log.trace('executing the following query:\n$rawQuery');

    final res = await _connection.mappedResultsQuery(rawQuery);

    // for some reason the table key is empty.
    // result coming like this: `{: {table_name: some_name, column_name: some_name, udt_name: text, is_nullable: NO}}`
    final resultKey = "";
    // final tables = <String>{};
    final tables = <Table>[];
    for (final row in res) {
      final result = row[resultKey];
      final tableName = result?[InfoSchemaColumnNames.tableName];
      // the query ensures the table names are sorted so we can do this
      if (tables.isEmpty || tableName != tables.last.tableName) {
        Log.trace('reading table: $tableName');
        tables.add(Table(result?[InfoSchemaColumnNames.schemaName], tableName, <ColumnData>[]));
      }
      // get column data
      final columnName = result?[InfoSchemaColumnNames.columnName];
      final dataType = result?[InfoSchemaColumnNames.dataType];
      final isNullable = result?[InfoSchemaColumnNames.isNullable].toLowerCase() == 'yes' ? true : false;

      Log.trace('   read column: $columnName');
      final columnData = ColumnData(
        tableName: tableName,
        columnName: columnName,
        dataType: dataType,
        isNullable: isNullable,
      );
      tables.last.columns.add(columnData);
    }
    return tables;
  }

  Future<void> disconnect() async {
    await _connection.close();
  }
}

String _buildColumnTypesQuery({
  required List<String> schemaNames,
  required List<String> tableNames,
}) {
  String rawQuery = '''
      select *
      from (with types as (
          select n.nspname,
                 pg_catalog.format_type(t.oid, null) as table_name
          from pg_catalog.pg_type t
                   join pg_catalog.pg_namespace n
                        on n.oid = t.typnamespace
          where (t.typrelid = 0
              or (select c.relkind = 'c'
                  from pg_catalog.pg_class c
                  where c.oid = t.typrelid))
            and not exists(
                  select 1
                  from pg_catalog.pg_type el
                  where el.oid = t.typelem
                    and el.typarray = t.oid)
                    and ${(schemaNames.length == 1) ? 'n.nspname = ${schemaNames[0]}' : (schemaNames.length > 1) ? 'n.nspname in (' + schemaNames.reduce((s1, s2) => s1.startsWith("'") ? "$s1, '$s2'" : "'$s1', '$s2'") + ')' : ''}
      ),
                 t1 as (
                     select n.nspname::text AS schema_name, 
                          case
                                when position('.' in pg_catalog.format_type(t.oid, null)) > 0
                                    then split_part(pg_catalog.format_type(t.oid, null), '.', 2)
                                else pg_catalog.format_type(t.oid, null) end                as table_name,
                            a.attname::text                                                 as column_name,
                            (select typname from pg_catalog.pg_type where oid = a.atttypid) as udt_name,
                            case
                                when a.attnotnull = true then 'NO'
                                else 'YES'
                                end                                                         as is_nullable
                     from pg_catalog.pg_attribute a
                              join pg_catalog.pg_type t
                                   on a.attrelid = t.typrelid
                              join pg_catalog.pg_namespace n
                                   on (n.oid = t.typnamespace)
                              join types
                                   on (types.nspname = n.nspname
                                       and types.table_name = pg_catalog.format_type(t.oid, null))
                     where a.attnum > 0
                       and not a.attisdropped
                 )
            select t1.schema_name,
                   t1.table_name,
                   t1.column_name,
                   t1.udt_name,
                   t1.is_nullable
            from t1
      
            union all
      
            select *
            from (select table_schema as schema_name, table_name, column_name, udt_name, is_nullable
                  from information_schema.columns
                  ${(schemaNames.length == 1) ? 'where table_schema = ${schemaNames[0]}' : (schemaNames.length > 1) ? 'where table_schema in (' + schemaNames.reduce((s1, s2) => s1.startsWith("'") ? "$s1, '$s2'" : "'$s1', '$s2'") + ')' : ''}
      
                  ORDER BY table_name, ordinal_position asc) as t2
           ) tables
      ${(tableNames.length == 1) ? 'where table_name = ${tableNames[0]};' : (tableNames.length > 1) ? 'where table_name in (' + tableNames.reduce((t1, t2) => t1.startsWith("'") ? "$t1, '$t2'" : "'$t1', '$t2'") + ');' : ';'}
  ''';

  return rawQuery;
}
