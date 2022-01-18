import 'dart:io';

import 'package:schema_dart/src/logger.dart';
import 'package:schema_dart/src/table_reader.dart';
import 'package:schema_dart/src/types_generator.dart';

import 'types.dart';

class SchemaConverter {
  final String connectionString;
  final Directory outputDirectory;

  final _tables = <Table>[];

  SchemaConverter(this.connectionString, this.outputDirectory);

  Future<void> convert() async {
    Log.trace('started reading tables');
    await _readTables();
    Log.trace('started generating dart types');
    await _generateDartTypes();
  }

  Future<void> _readTables() async {
    final reader = TablesReader.fromConnectionString(connectionString);
    Log.trace('connecting to database');
    await reader.connect();
    Log.trace('calling TablesReader.getTables');
    final tables = await reader.getTables();
    Log.trace('disconnecting the database');
    await reader.disconnect();
    _tables.clear();
    _tables.addAll(tables);
  }

  Future<void> _generateDartTypes() async {
    final generator = TypesGenerator(
      outputDirectory: outputDirectory,
      tables: _tables,
    );
    await generator.generate();
  }
}
