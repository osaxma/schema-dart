import 'dart:io';

import 'package:args/args.dart';
import 'package:meta/meta.dart';
import 'package:schema_dart/src/logger.dart';
import 'package:schema_dart/src/table_reader.dart';
import 'package:schema_dart/src/types_generator.dart';
import 'package:path/path.dart' as p;

import 'config.dart';
import 'model.dart';

class SchemaConverter {
  final String connectionString;
  final Directory outputDirectory;

  /// the schema to generate data classes from
  final String schemaName;

  /// an optional list of tables to generate the data classes fromƒ
  final List<String>? tableNames;

  final bool disableSSL;

  final TypesGeneratorConfig config;

  final _tables = <Table>[];

  SchemaConverter({
    required this.connectionString,
    required this.outputDirectory,
    required this.schemaName,
    this.config = const TypesGeneratorConfig(),
    this.tableNames,
    this.disableSSL = false,
  });

  factory SchemaConverter.fromArguments(ArgResults args) {
    final disableSSL = args['no-ssl'];

    final connectionString = args['connection-string'] as String;
    final outputDirectory = Directory(args['output-dir'] as String);

    final schema = args['schema'];

    final listOfTables = args['tables'];

    final config = TypesGeneratorConfig(
      nullableFields: args['nullable-fields'],
      nullableDefaults: args['nullable-defaults'],
      nullableIds: args['nullable-ids'],
      useUtc: args['use-utc']
    );

    return SchemaConverter(
      connectionString: connectionString,
      outputDirectory: outputDirectory,
      schemaName: schema,
      tableNames: listOfTables,
      disableSSL: disableSSL,
      config: config,
    );
  }

  Future<void> convert() async {
    await processTables();

    // write sources to output directory
    Log.trace('writing files to output directory');
    var progress = Log.progress('generating dart source code for tables');
    await _writeFilesToOutputDirectory();
    progress.finish(message: 'files were written at ${outputDirectory.path}');
  }

  @visibleForTesting
  Future<List<Table>> processTables() async {
    Log.trace('started reading tables');
    var progress = Log.progress('reading tables');

    try {
      await _readTables();
    } catch (e) {
      progress.cancel();
      rethrow;
    }
    progress.finish(message: 'found ${_tables.length} - tables');

    // generate source code
    Log.trace('generating dart classes');
    progress = Log.progress('generating dart source code for tables');
    await _addDartSourceToTables();
    progress.finish(message: 'sources were generated.');
    return _tables;
  }

  Future<void> _readTables() async {
    final reader = TablesReader.fromConnectionString(connectionString, disableSSL: disableSSL);
    Log.trace('connecting to database');
    await reader.connect();
    Log.trace('calling TablesReader.getTables');
    final tables = await reader.getTables(schemaName: schemaName, tableNames: tableNames, config: config);
    Log.trace('disconnecting the database');
    await reader.disconnect();
    _tables.clear();
    _tables.addAll(tables);
  }

  Future<void> _addDartSourceToTables() async {
    final generator = TypesGenerator(
      outputDirectory: outputDirectory,
      tables: _tables,
      config: TypesGeneratorConfig(),
    );
    await generator.addDartSourceToTables();
  }

  Future<void> _writeFilesToOutputDirectory() async {
    final futures = <Future>[];
    Log.trace('writing files');
    for (final table in _tables) {
      final file = File(p.join(outputDirectory.path, table.tableName + '.g.dart'));
      futures.add(file.create(recursive: true).then((value) => file.writeAsString(table.source)));
    }

    await Future.wait(futures);
  }
}
