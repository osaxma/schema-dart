import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:schema_dart/src/schema_converter.dart';
import 'package:schema_dart/src/version.dart';

import 'logger.dart';

class DartSchemaRunner extends CommandRunner<void> {
  DartSchemaRunner()
      : super(
          'Schema Dart',
          'Schema Dart - generate dart type definitions from PostgreSQL schema',
        ) {
    argParser.addOption(
      'connection-string',
      abbr: 'c',
      mandatory: true,
      help: 'PostgreSQL connection string in the following format:\n'
          'postgresql://<username>:<password>@<host>:<port>/<database-name>',
    );

    argParser.addOption(
      'output-dir',
      abbr: 'o',
      mandatory: true,
      help: 'The output directory for the generated dart files',
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
  Future<void> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      // ignore: avoid_print
      Log.stdout(schemaDartVersion);
      return;
    }

    if (topLevelResults['verbose'] == true) {
      Log.verbose = true;
    }

    final connectionString = topLevelResults['connection-string'] as String;
    final outputDirectory = Directory(topLevelResults['output-dir'] as String);

    // if (!outputDirectory.existsSync()) {
    //   throw Exception('The given output directory does not exist: ${outputDirectory.path}');
    // }

    final converter = SchemaConverter(connectionString, outputDirectory);

    await converter.convert();
  }
}