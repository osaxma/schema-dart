import 'dart:io';

import 'types.dart';

/// Generates Dart type definitions (aka data classes)
class TypesGenerator {
  final Directory outputDirectory;

  final List<Table> tables;

  TypesGenerator(this.outputDirectory, this.tables);

  Future<void> generate() async {}
}
