import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:postgres/postgres.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:path/path.dart' as p;

import '../docker.dart';

void main() {
  withPostgresServer('Read Tables from Database', (server) {
    late Connection connection;

    setUpAll(() async {
      connection = await server.newConnection(
        sslMode: SslMode.disable,
      );
      await _createSampleTables(connection);
    });

    test('generate dart valid file', () async {
      final parent = Directory.current.path;
      final targetPath = p.join(parent, 'test/out');

      // sanity check so we don't create files in unknown location
      expect(p.isWithin(parent, '$targetPath/schema-dart/test/out'), true);

      final outputDirectory = Directory(targetPath);

      final convertor = SchemaConverter(
        connectionString: await server.connectionString,
        outputDirectory: outputDirectory,
        schemaName: 'public',
        tableNames: [_sampleTableName],
      );

      await convertor.convert();
      
      final content = File(p.join(outputDirectory.path, '$_sampleTableName.g.dart')).readAsStringSync();
      // this would throw if the program has errors
      DartFormatter().format(content);
    });
  });
}

/* -------------------------------------------------------------------------- */
/*                                  test data                                 */
/* -------------------------------------------------------------------------- */

Future<void> _createSampleTables(Connection connection) async {
  await connection.execute(_sampleTables);
}

final _sampleTableName = 'sample_table1';
final _sampleTables = 'CREATE TABLE public.sample_table1 ('
    'id int, '
    'isSomething boolean, '
    'name text, '
    'someDouble double precision, '
    'dob date, '
    'sometime timestamp, '
    'listOfbool _bool, '
    'listOfints _int8, '
    'listOfStrings _text'
    ')';
