import 'package:built_collection/built_collection.dart'; 
import 'package:code_builder/code_builder.dart';
import 'package:schema_dart/src/model.dart';

import 'types_generator.dart';

class DataClassBuilder {
  final Table table;
  final TypesGeneratorConfig config;
  late final DartEmitter dartEmitter;

  DataClassBuilder({
    required this.table,
    required this.config,
    bool orderDirectives = true,
    bool useNullSafetySyntax = true,
  }) : dartEmitter = DartEmitter(
          orderDirectives: orderDirectives,
          useNullSafetySyntax: useNullSafetySyntax,
        );

  late final ClassBuilder classBuilder = ClassBuilder();
  late final _TypeBuilderInput _input = _TypeBuilderInput.fromTable(table);

  bool get hasCollection => _input.hasCollection;

  bool get requiresConvertImport => config.generateSerialization;

  bool get requiresCollectionImport => hasCollection && config.generateEquality;

  String get className => table.dartClassName;

  List<_Field> get _fields => _input.fields;

  String build() {
    // assign the class name
    classBuilder.name = className;

    buildDefaultConstructor();
    buildFields();

    if (config.generateCopyWith) {
      buildCopyWithMethod();
    }
    if (config.generateSerialization) {
      buildSerialization();
    }
    if (config.generateEquality) {
      buildEqualityMethods();
      buildHashCodeGetter();
    }
    if (config.generateToString) {
      buildToStringMethod();
    }

    String source = generateSource();

    if (requiresConvertImport) {
      // add collection import to source
      source = "import '$_dartConvertImportUri';\n" + source;
    }

    if (requiresCollectionImport) {
      // add convert import to source
      source = "import '$_collectionImportUri';\n" + source;
    }

    return source;
  }

  String generateSource() => classBuilder.build().accept(dartEmitter).toString();

  void buildFields() {
    final classFields = <Field>[];
    for (var field in _fields) {
      classFields.add(Field((b) {
        b
          ..name = field.name
          ..modifier = FieldModifier.final$
          // if we pull postgresql column/table comments, we can add them here.
          // ..docs = ListBuilder<String>(field.comment)
          ..type = field.typeReference;
      }));
    }

    classBuilder.fields.addAll(classFields);
  }

  void buildDefaultConstructor() {
    // first create the constructor parameters
    final namedParameters = <Parameter>[];

    for (final field in _fields) {
      namedParameters.add(
        Parameter(
          (b) {
            b
              ..name = field.name
              ..named = true
              ..toThis = true
              ..required = !field.isNullable;
          },
        ),
      );
    }

    classBuilder.constructors.add(Constructor((b) {
      b
        ..optionalParameters = ListBuilder(namedParameters)
        ..constant = true;
    }));
  }

  void buildCopyWithMethod() {
    // create the parameters
    final parameters = <Parameter>[];
    parameters.addAll(
      _fields.map(
        (p) => Parameter(
          (b) {
            b
              ..name = p.name
              ..named = true
              ..type = p.typeRefAsNullable;
          },
        ),
      ),
    );

    // addTrailingCommaToParameters(parameters);

    // create the body
    final body = _fields
        .map((field) => '${field.name}: ${field.name} ?? this.${field.name}')
        .reduce((value, element) => value + ',' + element);

    final copyWithMethod = Method((b) {
      b
        ..returns = refer(className)
        ..name = 'copyWith'
        ..body = Code('return $className($body,);')
        ..optionalParameters = ListBuilder(parameters);
    });

    classBuilder.methods.add(copyWithMethod);
  }

  void buildEqualityMethods() {
    final method = Method((b) {
      b
        ..name = '=='
        ..returns = refer('bool operator')
        ..requiredParameters = ListBuilder([
          Parameter((b) {
            b
              ..name = 'other'
              ..type = refer('Object');
          })
        ])
        ..annotations = overrideAnnotation()
        ..body = generateEqualityOperatorBody();
    });

    classBuilder.methods.add(method);
  }

  // create the body of the method
  Code generateEqualityOperatorBody() {
    final params = _fields.map((field) {
      if (field.isCollection) {
        return 'collectionEquals(other.${field.name}, ${field.name})';
      } else {
        return 'other.${field.name} == ${field.name}';
      }
    }).reduce((prev, next) => prev + '&&' + next);

    final collectionEquality = hasCollection ? 'final collectionEquals = const DeepCollectionEquality().equals;' : '';

    return Code('''
  if (identical(this, other)) return true;
  $collectionEquality

  return other is $className && $params;
  ''');
  }

  void buildHashCodeGetter() {
    final params = _fields.map((field) => '${field.name}.hashCode').reduce((prev, next) => prev + '^' + next);
    final method = Method((b) {
      b
        ..name = 'hashCode'
        ..type = MethodType.getter
        ..returns = refer('int')
        ..annotations = overrideAnnotation()
        ..body = Code('return $params;');
    });
    classBuilder.methods.add(method);
  }

  void buildSerialization() {
    buildToMapMethod();
    buildFromMapConstructor();
    buildFromJsonConstructor();
    buildToJsonMethod();
  }

  void buildToMapMethod() {
    final body = _fields.map((field) => field.toMapKeyAndValueString).reduce((value, element) => value + ',' + element);
    final method = Method((b) {
      b
        ..name = 'toMap'
        ..returns = refer('Map<String, dynamic>')
        ..body = Code('return {$body,};');
    });

    classBuilder.methods.add(method);
  }

  void buildFromMapConstructor() {
    final constructorBody =
        _fields.map((p) => p.fromMapArgumentAndAssignmentString).reduce((value, element) => value + ',' + element);
    // return Code('return ${clazz.name.name}($body,);');

    final constructor = Constructor((b) {
      b
        ..name = 'fromMap'
        ..factory = true
        ..requiredParameters = ListBuilder<Parameter>([
          Parameter((b) {
            b
              ..name = 'map'
              ..type = refer('Map<String, dynamic>');
          })
        ])
        ..body = Code('return $className($constructorBody,);');
    });

    classBuilder.constructors.add(constructor);
  }

  void buildFromJsonConstructor() {
    final constructor = Constructor((b) {
      b
        ..name = 'fromJson'
        ..factory = true
        ..requiredParameters = ListBuilder<Parameter>([
          Parameter((b) {
            b
              ..name = 'source'
              ..type = refer('String');
          })
        ])
        ..lambda = true
        ..body = Code('$className.fromMap(json.decode(source))');
    });
    classBuilder.constructors.add(constructor);
  }

  void buildToJsonMethod() {
    final method = Method((b) {
      b
        ..name = 'toJson'
        ..returns = refer('String')
        ..lambda = true
        ..body = Code('json.encode(toMap())');
    });

    classBuilder.methods.add(method);
  }

  void buildToStringMethod() {
    final params = _fields.map((p) => p.name + ': ' '\$${p.name}').reduce((prev, next) => prev + ', ' + next);
    final method = Method((b) {
      b
        ..name = 'toString'
        ..returns = refer('String')
        ..annotations = overrideAnnotation()
        ..body = Code("return '$className($params)';");
    });
    classBuilder.methods.add(method);
  }

  // helper method
  ListBuilder<Expression> overrideAnnotation() {
    return ListBuilder(const [CodeExpression(Code('override'))]);
  }

  /// adds a trailing comma if the [params] is not empty
  // void addTrailingCommaToParameters(List<Parameter> params) {
  //   if (params.isNotEmpty) {
  //     // Since there's no method in the Builders to add a trailing comma,
  //     // This adds an empty parameter which will add a comma as a trailing one.
  //     params.add(Parameter((b) => b.name = ''));
  //   }
  // }
}

const _dartConvertImportUri = "dart:convert";
const _collectionImportUri = "package:collection/collection.dart";

class _TypeBuilderInput {
  final List<_Field> fields;
  final String className;

  /// Whether any field has a collection
  ///
  /// This is used to determine of `collection` library should be imported.
  final bool hasCollection;

  _TypeBuilderInput(
    this.fields,
    this.hasCollection,
    this.className,
  );

  factory _TypeBuilderInput.fromTable(Table table) {
    final fields = <_Field>[];
    bool hasCollection = false;

    for (var column in table.columns) {
      final field = _Field(
        columnKey: column.name,
        name: column.dartName,
        type: column.dartType,
        isNullable: column.isNullable,
      );
      fields.add(field);
      if (field.isCollection && !hasCollection) {
        hasCollection = true;
      }
    }

    return _TypeBuilderInput(fields, hasCollection, table.dartClassName);
  }
}

class _Field {
  /// The column name as it appears in PostgreSQL
  ///
  /// This is used as a key when extracting the data from json.
  final String columnKey;

  /// The dart name for this field.
  final String name;
  final bool isNullable;
  final String type;
  final Reference typeReference;
  final bool useUTC;

  _Field({
    required this.columnKey,
    required this.name,
    required this.isNullable,
    required this.type,
    // TODO: figure out why this was here
    // ignore: unused_element
    this.useUTC = true,
  }) : typeReference = refer(type);

  Reference? get typeRefAsNullable => isNullable ? typeReference : refer(type + '?');

  // note: we only deal with lists since types are generated from PostgreSQL
  bool get isCollection => type.startsWith('List');

  String get toMapKeyAndValueString {
    final key = columnKey;
    String value = name;

    if (type == 'DateTime') {
      if (useUTC) {
        value = value + '.toUtc()';
      }
      value = value + '.toIso8601String()';
    }
    return "'$key':$value";
  }

  String get fromMapArgumentAndAssignmentString {
    final arg = name;
    String assignment = name;
    String mapKey = "map['$columnKey']";

    switch (type.replaceAll('?', '')) {
      case 'num':
      case 'dynamic':
      case 'bool':
      case 'Object':
      case 'String':
        assignment = mapKey;
        break;
      case 'int':
        // - int --> map['fieldName']?.toInt()       OR     int.parse(map['fieldName'])
        assignment = isNullable ? 'int.tryParse($mapKey ?? "")' : 'int.parse($mapKey)';
        break;
      case 'double':
        // - double --> map['fieldName']?.double()   OR     double.parse(map['fieldName'])
        // note: dart, especially when used with web, would convert double to integer (1.0 -> 1) so account for it.
        assignment = isNullable ? 'double.tryParse($mapKey ?? "")' : 'double.parse($mapKey)';
        break;
      case 'DateTime':
        assignment = isNullable ? 'DateTime.tryParse($mapKey ?? "")' : 'DateTime.parse($mapKey)';
        break;
    }

    if (isCollection) {
      // TODO: account for List<DateTime> since it's a List<String> 
      //       unlike List<int>, List<double>, etc. which comes in the same type
      assignment = isNullable ? '$mapKey == null ? null : ${type.replaceAll('?', '')}.from($mapKey)' : '$type.from($mapKey)';
    }

    return '$arg: $assignment';
  }
}
