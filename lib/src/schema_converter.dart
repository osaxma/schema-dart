import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:schema_dart/src/file_contents.dart';
import 'package:schema_dart/src/logger.dart';
import 'package:schema_dart/src/postgres_reader.dart';
import 'package:schema_dart/src/types_generator.dart';

import 'types.dart';

class SchemaConverter {
  final String connectionString;
  final Directory outputDirectory;

  late final PostgresReader postgresReader;

  /// an optional list of schemas to generate data classes from
  final List<String>? schemaNames;
  final _schemas = <String>[];

  /// an optional list of tables to generate the data classes from
  final List<String>? tableNames;
  final _tables = <Table>[];

  SchemaConverter({
    required this.connectionString,
    required this.outputDirectory,
    this.schemaNames,
    this.tableNames,
  });

  Future<void> convert() async {
    // read schemas
    Log.trace('started reading schemas');
    var progress = Log.progress('reading schemas');
    await _readSchemas();
    progress.finish(message: 'found ${-_schemas.length} - schemas');

    // read tables
    Log.trace('started reading tables');
    progress = Log.progress('reading tables');
    await _readTables();
    progress.finish(message: 'found ${_tables.length} - tables in $_schemas');

    Log.trace('disconnecting the database');
    await postgresReader.disconnect();

    // generate source code
    Log.trace('generating dart classes');
    progress = Log.progress('generating dart source code ®for tables');
    await _addDartSourceToTables();
    progress.finish(message: 'sources were generated.');

    // write sources to output directory
    Log.trace('writing files to output directory');
    progress = Log.progress('generating dart source code for tables');
    await _writeFilesToOutputDirectory();
    progress.finish(message: 'files were written at ${outputDirectory.path}');
  }

  Future<void> _readSchemas() async {
    postgresReader = PostgresReader.fromConnectionString(connectionString);
    Log.trace('connecting to database');
    await postgresReader.connect();
    Log.trace('calling PostgresReader.getSchemas');
    final schemas = await postgresReader.getSchemas(schemaNames: schemaNames);
    _schemas.clear();
    _schemas.addAll(schemas);
  }

  Future<void> _readTables() async {
    Log.trace('calling TablesReader.getTables');
    final tables = await postgresReader.getTables(schemaNames: _schemas, tableNames: tableNames);
    _tables.clear();
    _tables.addAll(tables);
  }

  Future<void> _addDartSourceToTables() async {
    final generator = TypesGenerator(
      outputDirectory: outputDirectory,
      tables: _tables,
    );
    await generator.addDartSourceToTables();
  }

  Future<void> _writeFilesToOutputDirectory() async {
    final futures = <Future>[];

    Log.trace('creating json.g.dart');
    final jsonFile = File(path.join(outputDirectory.path, 'json.g.dart'));
    futures.add(jsonFile.create(recursive: false).then((value) => jsonFile.writeAsString(jsonFileSource)));

    Log.trace('writing files');
    for (final table in _tables) {
      final file = File(path.join(table.schemaName, outputDirectory.path, table.tableName + '.g.dart'));
      futures.add(file.create(recursive: true).then((value) => file.writeAsString(table.source)));
    }

    await Future.wait(futures);

    Log.trace('creating models.g.dart');
    String exports = '';
    final modelsFile = File(path.join(outputDirectory.path, 'models.g.dart'));

    await for (final dir in outputDirectory.list()) {
      if (dir is Directory) {
        final dirName = path.basename(dir.path);
        await for (final file in dir.list()) {
          if (file.path.endsWith('.g.dart')) {
            final dartFileName = path.basename(file.path);
            exports += 'export \'./$dirName/$dartFileName\';\n';
          }
        }
      }
    }
    await modelsFile.create(recursive: false).then((value) => modelsFile.writeAsString(exports));
  }
}
