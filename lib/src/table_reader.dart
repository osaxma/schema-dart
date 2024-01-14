import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';

import 'logger.dart';
import 'types.dart';

class TablesReader {
  late final Connection _connection;

  late final String host;
  late final String databaseName;
  late final int port;
  late final String? username;
  late final String? password;
  final Duration timeout;
  final Duration queryTimeout;
  final bool disableSSL;

  TablesReader({
    required this.host,
    required this.databaseName,
    required this.port,
    this.username,
    this.password,
    this.timeout = const Duration(seconds: 30),
    this.queryTimeout = const Duration(seconds: 30),
    this.disableSSL = false,
  });

  TablesReader.fromConnectionString(
    String connectionString, {
    this.timeout = const Duration(seconds: 30),
    this.queryTimeout = const Duration(seconds: 30),
    this.disableSSL = false,
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

    if (connectionString.replaceFirst('@', '').contains('@')) {
      throw FormatException('Looks like the `@` symbol is used in the password.\n'
          'replace it with: %40  -- the URL encoding for `@`');
    }

    if (parts.length < 5) {
      throw FormatException('Could not find all five required values:\n'
          'username, password, host, port, databaseName.\n'
          'make sure the connection string is formatted as follow:\n'
          'postgresql://<username>:<password>@<host>:<port>/<database-name>');
    }

    if (int.tryParse(parts[3]) == null) {
      throw FormatException('The port is not formatted correctly, expected an `integer` but got ${parts[3]}');
    }

    /// assign fields:
    username = parts[0];
    password = parts[1];
    host = parts[2];
    port = int.parse(parts[3]);
    databaseName = parts[4];
  }

  Future<void> connect() async {
    _connection = await Connection.open(
      Endpoint(
        host: host,
        database: databaseName,
        port: port,
        username: username,
        password: password,
      ),
      settings: ConnectionSettings(
        sslMode: disableSSL ? SslMode.disable : SslMode.require,
      ),
    );
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
    final rawQuery = buildColumnTypesQuery(tableNames: tableNames, schemaName: schemaName);

    Log.trace('executing the following query:\n$rawQuery');

    final Result res = await _connection.execute(rawQuery);

    final tables = <Table>[];
    for (ResultRow row in res) {
      // final map =
      final result = row.toColumnMap();
      final tableName = result[InfoSchemaColumnNames.tableName];
      // the query ensures the table names are sorted so we can do this
      if (tables.isEmpty || tableName != tables.last.tableName) {
        Log.trace('reading table: $tableName');
        tables.add(Table(tableName, <ColumnData>[]));
      }
      // get column data
      final columnName = result[InfoSchemaColumnNames.columnName];
      final dataType = result[InfoSchemaColumnNames.dataType];
      final isNullable = result[InfoSchemaColumnNames.isNullable].toLowerCase() == 'yes' ? true : false;

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

  // Future<Result> query(String rawQuery) async {
  //   return (query);
  // }

  Future<void> disconnect() async {
    await _connection.close();
  }

  @visibleForTesting
  String buildColumnTypesQuery({
    required String schemaName,
    required List<String> tableNames,
  }) {
    final columns = InfoSchemaColumnNames.all.reduce((c1, c2) => c1 + ', ' + c2);
    String rawQuery = '''
SELECT $columns
FROM information_schema.columns
WHERE table_schema = '$schemaName'
''';
    if (tableNames.length == 1) {
      rawQuery = rawQuery + "AND table_name = '${tableNames[0]}'";
    } else if (tableNames.length > 1) {
      final tableNamesString = tableNames.map((t) => "'$t'").reduce((t1, t2) {
        return "$t1, $t2";
      });
      rawQuery = rawQuery + 'AND table_name in (' + tableNamesString + ')';
    }

    rawQuery = rawQuery + 'ORDER BY table_name ASC;';

    return rawQuery;
  }
}
