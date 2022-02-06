import 'package:postgres/postgres.dart';

import 'logger.dart';
import 'types.dart';

class TablesReader {
  late final PostgreSQLConnection _connection;

  final String host;
  final String databaseName;
  final int port;
  final String? username;
  final String? password;
  final Duration timeout;
  final Duration queryTimeout;

  TablesReader({
    required this.host,
    required this.databaseName,
    required this.port,
    this.username,
    this.password,
    this.timeout = const Duration(seconds: 30),
    this.queryTimeout = const Duration(seconds: 30),
  });

  factory TablesReader.fromConnectionString(
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

    return TablesReader(
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

  /// Retrieve the postgres type for all columns
  ///
  /// The [schemaName] defaults to `public`.
  /// Provide [tableNames] to retrieve data for specific tables only,
  /// an empty list (default) indicates all tables.
  Future<List<Table>> getTables({
    String schemaName = 'public',
    List<String>? tableNames,
  }) async {
    tableNames ??= const <String>[];
    final rawQuery = _buildColumnTypesQuery(tableNames: tableNames, schemaName: schemaName);

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
        tables.add(Table(tableName, <ColumnData>[]));
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
  required String schemaName,
  required List<String> tableNames,
}) {
  String rawQuery = '''
      WITH types AS (
          SELECT n.nspname,
                 pg_catalog.format_type ( t.oid, NULL ) AS table_name
          FROM pg_catalog.pg_type t
                   JOIN pg_catalog.pg_namespace n
                        ON n.oid = t.typnamespace
          WHERE ( t.typrelid = 0
              OR ( SELECT c.relkind = 'c'
                   FROM pg_catalog.pg_class c
                   WHERE c.oid = t.typrelid ) )
            AND NOT EXISTS (
                  SELECT 1
                  FROM pg_catalog.pg_type el
                  WHERE el.oid = t.typelem
                    AND el.typarray = t.oid )
            AND n.nspname = '$schemaName'
      ),
           cols AS (
               SELECT pg_catalog.format_type ( t.oid, NULL ) AS table_name,
                      a.attname::text AS column_name,
                      pg_catalog.format_type ( a.atttypid, a.atttypmod ) AS udt_name,
                      CASE
                          WHEN a.attnotnull = true THEN 'NO'
                          WHEN a.attnotnull = false THEN 'YES'
                      END AS is_nullable
               FROM pg_catalog.pg_attribute a
                        JOIN pg_catalog.pg_type t
                             ON a.attrelid = t.typrelid
                        JOIN pg_catalog.pg_namespace n
                             ON ( n.oid = t.typnamespace )
                        JOIN types
                             ON ( types.nspname = n.nspname
                                 AND types.table_name = pg_catalog.format_type ( t.oid, NULL ) )
               WHERE a.attnum > 0
                 AND NOT a.attisdropped
           )
      SELECT cols.table_name,
             cols.column_name,
             cols.udt_name,
             cols.is_nullable
      FROM cols
      
      UNION ALL
      
      SELECT table_name, column_name, udt_name, is_nullable
      FROM information_schema.columns
      WHERE table_schema = '$schemaName'
  ''';

  if (tableNames.length == 1) {
    rawQuery = rawQuery + "AND table_name = '${tableNames[0]}'";
  } else if (tableNames.length > 1) {
    rawQuery = rawQuery + 'AND table_name in (' + tableNames.reduce((t1, t2) => "'$t1', '$t2'") + ')';
  }

  rawQuery = rawQuery + 'ORDER BY table_name ASC;';

  return rawQuery;
}
