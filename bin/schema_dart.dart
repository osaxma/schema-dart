import 'dart:io';

import 'package:schema_dart/schema_dart.dart';

void main(List<String> args) async {
  try {
    await SchemaDartRunner().run(args);
    exitCode = 0;
  } catch (e) {
    print(e);
    exitCode = 1;
  }
}
