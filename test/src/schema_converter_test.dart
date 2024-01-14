import 'dart:io';

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


