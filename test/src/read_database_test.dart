import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:schema_dart/src/table_reader.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:path/path.dart' as p;

import '../docker.dart';

void main() {
  withPostgresServer('Read Tables from Database', (server) {
    late Connection connection;
    late final TablesReader reader;

    setUpAll(() async {
      connection = await server.newConnection(
        sslMode: SslMode.disable,
      );
      await _createSampleTables(connection);
      reader = TablesReader(
        host: 'localhost',
        databaseName: 'postgres',
        port: await server.port,
        username: 'postgres',
        password: 'postgres',
      );
      await reader.connect();
    });

    tearDownAll(() async => await reader.disconnect());

    test('read sample table', () async {
      final tables = await reader.getTables(schemaName: 'public');

      expect(tables.length, _expectedResults.length);

      for (var table in tables) {
        // table must exist in sample tables
        expect(_expectedResults.containsKey(table.tableName), true);
        final expectedColumns = _expectedResults[table.tableName]!;
        expect(expectedColumns.length, table.columns.length);

        for (var column in table.columns) {
          expect(expectedColumns.containsKey(column.columnName), true);
          final expectedDataType = expectedColumns[column.columnName]!;
          // TODO: our sample table is all nullable
          expect(column.dartType.replaceAll('?', ''), expectedDataType,
              reason: '${column.columnName} dart type: ${column.dartType} != $expectedDataType');
        }
      }

      await reader.disconnect();
    });

    test('generate dart valid file', () async {
      final parent = Directory.current.path;
      final targetPath = p.join(parent, 'test/out');
      // sanity check so we don't create files in unknown location
      expect(p.isWithin(parent, '$targetPath/schema-dart/test/out'), true);

      // if (!Directory(targetPath).existsSync()) {
      //   Directory(targetPath).createSync();
      // }

      final convertor = SchemaConverter(
        connectionString: 'postgresql://postgres:postgres@localhost:${await server.port}/postgres',
        outputDirectory: Directory(targetPath),
        schemaName: 'public',
      );

      await convertor.convert();
    });
  });
}

/* -------------------------------------------------------------------------- */
/*                                  test data                                 */
/* -------------------------------------------------------------------------- */

Future<void> _createSampleTables(Connection connection) async {
  await connection.execute(_sampleTables);
}

final _sampleTables = 'CREATE TABLE public.sample_table1 '
    '(i int, s serial, bi bigint, '
    'bs bigserial, bl boolean, si smallint, '
    't text, f real, d double precision, '
    'dt date, ts timestamp, tsz timestamptz, j jsonb, u uuid, '
    'v varchar, jj json, ia _int4, bia _int8, ta _text, da _float8, ja _jsonb, va _varchar(20), '
    'ba _bool'
    // ' , p point,' // TODO
    ')';

// List<(String, String)> _columns = [];

final _expectedResults = /* <columnName, dart type> */ {
  'sample_table1': {
    'i': 'int', // 'int',
    's': 'int', // 'serial',
    'bi': 'int', // 'bigint',
    'bs': 'int', // 'bigserial',
    'bl': 'bool', // 'boolean',
    'si': 'int', // 'smallint',
    't': 'String', // 'text',
    'f': 'double', // 'real',
    'd': 'double', // 'double precision',
    'dt': 'DateTime', // 'date',
    'ts': 'DateTime', // 'timestamp',
    'tsz': 'DateTime', // 'timestamptz',
    'j': 'Object', // 'jsonb',
    'u': 'String', // 'uuid',
    'v': 'String', // 'varchar',
    'jj': 'Object', // 'json',
    'ia': 'List<int>', // '_int4',
    'bia': 'List<int>', // '_int8',
    'ta': 'List<String>', // '_text',
    'da': 'List<double>', // '_float8',
    'ja': 'List<Object>', // '_jsonb',
    'va': 'List<String>', // '_varchar(20)',
    'ba': 'List<bool>', // '_bool',
    // TODO:
    // 'p': '',   // 'point',
  }
};
