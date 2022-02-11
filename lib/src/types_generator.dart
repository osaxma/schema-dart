import 'dart:io';

import 'package:dart_style/dart_style.dart';

import 'data_class_builder.dart';
import 'types.dart';

/// Generates Dart type definitions (aka data classes) from [Table]s
class TypesGenerator {
  final Directory outputDirectory;

  final List<Table> tables;
  final TypesGeneratorConfig config;

  late final formatter = DartFormatter(pageWidth: 120);

  TypesGenerator({
    required this.outputDirectory,
    required this.tables,
    this.config = const TypesGeneratorConfig(),
  });

  Future<void> addDartSourceToTables() async {
    for (final table in tables) {
      // tell builder to import json.g.dart if the class is using it
      bool isUsingJson = false;
      table.columns.forEach((c) {
        if (c.dartType.contains('Json')) {
          isUsingJson = true;
        }
      });

      final builder = DataClassBuilder(config: isUsingJson ? JsonClassConfig() : config, table: table);
      final source = builder.build();
      table.source = formatter.format(source);
    }
  }
}

class TypesGeneratorConfig {
  final bool generateCopyWith;
  final bool generateSerialization;
  final bool generateEquality;
  final bool generateToString;
  final bool generateListBuilder;
  final bool generateJsonClass;

  const TypesGeneratorConfig({
    this.generateCopyWith = true,
    this.generateSerialization = true,
    this.generateEquality = true,
    this.generateToString = true,
    this.generateListBuilder = true,
    this.generateJsonClass = false,
  });
}

class ClassOnlyConfig extends TypesGeneratorConfig {
  const ClassOnlyConfig() : super(generateCopyWith: false, generateEquality: false, generateSerialization: false, generateToString: false, generateListBuilder: false, generateJsonClass: false);
}

class JsonClassConfig extends TypesGeneratorConfig {
  const JsonClassConfig() : super(generateCopyWith: true, generateEquality: true, generateSerialization: true, generateToString: true, generateListBuilder: true, generateJsonClass: true);
}
