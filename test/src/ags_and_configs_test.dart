import 'dart:io';

import 'package:args/args.dart';

import 'package:postgres/postgres.dart';
import 'package:schema_dart/schema_dart.dart';
import 'package:schema_dart/src/config.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../docker.dart';

final _exampleConnectionString = 'postgresql://username:password@host:port/database';
final _exampleOutDir = '/some/dir/out';

void main() {
  group('Arguments and TypeConfiguration tests', () {
    test('argument parsing', () async {
      final args =
          await _MockRunner().run(['-c', _exampleConnectionString, '-o', _exampleOutDir, '--no-ssl']) as ArgResults;

      final converter = SchemaConverter.fromArguments(args);
      expect(converter.connectionString, _exampleConnectionString);
      expect(converter.disableSSL, true);
      expect(converter.outputDirectory.path, _exampleOutDir);
      // TODO: test the rest of arguments
    });

    group('TypeConfiguration Parsing', () {
      test('- all nulls are false', () async {
        final args = await _MockRunner().run(['-c', _exampleConnectionString, '-o', _exampleOutDir]) as ArgResults;

        final configs = SchemaConverter.fromArguments(args).config;

        expect(configs.nullableDefaults, false);
        expect(configs.nullableFields, false);
        expect(configs.nullableIds, false);
      });
      test('- all nulls are true', () async {
        final args = await _MockRunner().run([
          '-c',
          _exampleConnectionString,
          '-o',
          _exampleOutDir,
          '--nullable-fields',
          '--nullable-ids',
          '--nullable-defaults',
        ]) as ArgResults;

        final configs = SchemaConverter.fromArguments(args).config;

        expect(configs.nullableDefaults, true);
        expect(configs.nullableFields, true);
        expect(configs.nullableIds, true);
      });
    });

    withPostgresServer('Types are generated according to TypeConfigurations', (server) {
      late Connection connection;

      setUpAll(() async {
        connection = await server.newConnection(
          sslMode: SslMode.disable,
        );
        await _createSampleTables(connection);
      });

      test('table is generated as expected', () async {
        final convertor = SchemaConverter(
          connectionString: await server.connectionString,
          outputDirectory: Directory.systemTemp,
          schemaName: 'public',
          tableNames: [_sampleTableName],
          config: TypesGeneratorConfig(),
        );

        final tables = await convertor.processTables();

        expect(tables.length, 1);

        final table = tables.first;

        final someid = table.columns.firstWhere((element) => element.name == 'someid');
        expect(someid.isIdentity, true);
        expect(someid.columnDefault, null);
        expect(someid.isNullable, false);
        expect(someid.identityGeneration, isNot(null));

        final somenumber = table.columns.firstWhere((element) => element.name == 'somenumber');
        expect(somenumber.isIdentity, false);
        expect(somenumber.isNullable, true);
        expect(somenumber.columnDefault, isNot(null));
        expect(somenumber.identityGeneration, null);
        final sometext = table.columns.firstWhere((element) => element.name == 'sometext');
        expect(sometext.isIdentity, false);
        expect(sometext.isNullable, true);
        expect(sometext.columnDefault, null);
        expect(sometext.identityGeneration, null);
        final sometime = table.columns.firstWhere((element) => element.name == 'sometime');
        expect(sometime.isIdentity, false);
        expect(sometime.isNullable, false);
        expect(sometime.columnDefault, isNot(null));
        expect(sometime.identityGeneration, null);
      });

      test('nullable fields', () async {
        final convertor = SchemaConverter(
          connectionString: await server.connectionString,
          outputDirectory: Directory.systemTemp,
          schemaName: 'public',
          tableNames: [_sampleTableName],
          config: TypesGeneratorConfig(nullableFields: true),
        );

        final tables = await convertor.processTables();

        expect(tables.length, 1);

        for (var t in tables) {
          for (var c in t.columns) {
            expect(
              c.isNullable,
              true,
              reason: 'column: ${c.name} in ${c.tableName} was supposed to be nullable but it wasnt',
            );
          }
        }
      });

      test('nullable ids', () async {
        final convertor = SchemaConverter(
          connectionString: await server.connectionString,
          outputDirectory: Directory.systemTemp,
          schemaName: 'public',
          tableNames: [_sampleTableName],
          config: TypesGeneratorConfig(nullableIds: true),
        );

        final tables = await convertor.processTables();

        expect(tables.length, 1);

        final identityColumns = tables.first.columns.where((e) => e.isIdentity).toList();
        expect(identityColumns.length, 1);
        expect(identityColumns.first.isNullable, true);
      });

      test('nullable defaults', () async {
        final convertor = SchemaConverter(
          connectionString: await server.connectionString,
          outputDirectory: Directory.systemTemp,
          schemaName: 'public',
          config: TypesGeneratorConfig(nullableDefaults: true),
        );

        final tables = await convertor.processTables();

        expect(tables.length, 1);

        final table = tables.first;

        final somenumber = table.columns.firstWhere((element) => element.name == 'somenumber');
        expect(somenumber.isNullable, true);

        final sometime = table.columns.firstWhere((element) => element.name == 'sometime');
        expect(sometime.isNullable, true);
      });
    });
  });
}

/* -------------------------------------------------------------------------- */
/*                                    MOCKS                                   */
/* -------------------------------------------------------------------------- */
// this will have all default options
// and the `runCommand` is overriden to just return the parsed results for testing
class _MockRunner extends SchemaDartRunner {
  @override
  Future<ArgResults> runCommand(ArgResults topLevelResults) {
    return Future.value(topLevelResults);
  }
}
/* -------------------------------------------------------------------------- */
/*                                  test data                                 */
/* -------------------------------------------------------------------------- */

Future<void> _createSampleTables(Connection connection) async {
  await connection.execute(_sampleTables);
}

final _sampleTableName = 'args_and_configs_test';
final _sampleTables = '''
CREATE TABLE public.$_sampleTableName(
someid INT GENERATED ALWAYS AS IDENTITY NOT NULL
,somenumber bigint DEFAULT 42
,sometext text
,sometime timestamp with time zone DEFAULT now() NOT NULL);
''';
