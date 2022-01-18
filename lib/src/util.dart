import 'dart:io';

extension StringUtils on String {
  String toUpperCaseFirst() => '${this[0].toUpperCase()}${substring(1)}';
  String toLowerCaseFirst() => '${this[0].toLowerCase()}${substring(1)}';

  /// this will remove extra spaces (i.e., > 1 space in sequence);
  String removeExtraSpace() => replaceAll(RegExp(r'\s{2,}'), ' ');

  /// Converts snake_case (postgres style) to camelCase (dart style)
  String convertSnakeCaseToCamelCase() {
    if (!contains('_')) return this;

    return split('_').reduce((value, element) => value + element.toUpperCaseFirst());
  }

  String toSnakeCase() {
    throw UnimplementedError();
  }

  /// trims leading whitespace
  String ltrim() {
    return replaceFirst(RegExp(r'^\s+'), '');
  }

  /// trims trailing whitespace
  String rtrim() {
    return replaceFirst(RegExp(r'\s+$'), '');
  }
}

int get terminalWidth {
  if (stdout.hasTerminal) {
    return stdout.terminalColumns;
  }

  return 80;
}
