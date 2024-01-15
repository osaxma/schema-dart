import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:schema_dart/src/version.dart';

import 'logger.dart';

class SchemaDartRunner extends CommandRunner<void> {
  SchemaDartRunner() : super('schema-dart', '') {
    argParser.addOption(
      'connection-string',
      abbr: 'c',
      // mandatory: true,
      help: 'PostgreSQL connection string in the following format:\n'
          'postgresql://<username>:<password>@<host>:<port>/<database-name>',
    );

    argParser.addOption(
      'output-dir',
      abbr: 'o',
      // mandatory: true,
      help: 'The output directory for the generated dart files',
    );

    argParser.addOption(
      'schema',
      abbr: 's',
      defaultsTo: 'public',
      help: 'specify the schema',
    );

    argParser.addMultiOption(
      'tables',
      abbr: 't',
      valueHelp: 'String',
      help: 'provide a specific list of tables to generate data classes for.\n'
          '(defaults to all tables)',
    );

    argParser.addFlag(
      'no-ssl',
      negatable: false,
      help: 'Disable SSL for postgres connection (not recommended)',
    );

    argParser.addFlag(
      'nullable-fields',
      abbr: 'n',
      negatable: false,
      help: 'When provided, all fields in generated class will be nullable '
          '(useful for partial table queries and for local table construction update/insert)',
    );

    argParser.addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Enable verbose logging.',
    );

    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
  }

  @override
  String get description => '''Generate Data Classes for PostgreSQL schema
  
Examples: 

  # generate data classes for public schema (default)
  schema-dart -c postgresql://postgres:postgres@localhost:54322/postgres -o path/to/output/directory

  # generate for data classes for a "cms" schema 
  schema-dart -c <connection-string> -o <output-dir> -s cms

  # generate data classes for specific tables from public schema (format sensitive): 
  schema-dart -c <connection-string> -o <output-dir> -t "users","posts"
  # or
  schema-dart -c <connection-string> -o <output-dir> --schema=api --tables="profiles","posts"
  ''';

  @override
  Future<void> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      Log.stdout(schemaDartVersion);
      return;
    }

    if (topLevelResults['verbose'] == true) {
      Log.verbose = true;
    }

    if (topLevelResults['help'] != false) {
      return super.runCommand(topLevelResults);
    }

    if (topLevelResults['connection-string'] == null) {
      throw Exception('connection-string is required');
    }

    final disableSSL = topLevelResults['no-ssl'];

    final connectionString = topLevelResults['connection-string'] as String;
    final outputDirectory = Directory(topLevelResults['output-dir'] as String);

    final schema = topLevelResults['schema'];

    final listOfTables = topLevelResults['tables'];

    final allNullables = topLevelResults['nullable-fields'];

    final converter = SchemaConverter(
      connectionString: connectionString,
      outputDirectory: outputDirectory,
      schemaName: schema,
      tableNames: listOfTables,
      disableSSL: disableSSL,
      allNullable: allNullables,
    );

    await converter.convert();
  }
}
