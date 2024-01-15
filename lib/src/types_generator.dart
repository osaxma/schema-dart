import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:schema_dart/src/logger.dart';

import 'data_class_builder.dart';
import 'model.dart';

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
      final builder = DataClassBuilder(config: config, table: table);
      final source = builder.build();
      try {
        // try formatting, if we could not, just use the unformatted code with errors
        // it will be helpful for debugging and for people to file issues.
        table.source = formatter.format(source);
      } catch (e, st) {
        Log.stderr('Something went wrong and failed to format code');
        if (Log.verbose) {
          Log.stderr(e.toString());
          Log.stderr(st.toString());
        }
        table.source = source;
      }
    }
  }
}

class TypesGeneratorConfig {
  final bool generateCopyWith;
  final bool generateSerialization;
  final bool generateEquality;
  final bool generateToString;

  const TypesGeneratorConfig({
    this.generateCopyWith = true,
    this.generateSerialization = true,
    this.generateEquality = true,
    this.generateToString = true,
  });
}

class ClassOnlyConfig extends TypesGeneratorConfig {
  const ClassOnlyConfig()
      : super(
          generateCopyWith: false,
          generateEquality: false,
          generateSerialization: false,
          generateToString: false,
        );
}
