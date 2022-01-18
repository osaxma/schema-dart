import 'dart:io';

import 'package:schema_dart/src/table_reader.dart';

class SchemaConverter {
  final String connectionString;
  final Directory outputDirectory;

  SchemaConverter(this.connectionString, this.outputDirectory);

  Future<void> convert() async {
    final client = TablesReader.fromConnectionString(connectionString);
    await client.connect();
    final tables = await client.getTables();
    await client.disconnect();

    for(var t in tables) {
      print('found table: ${t.tableName} with ${t.columns.length} columns');
    }


  }
}
