import 'package:schema_dart/src/config.dart';

import 'util.dart';

/// a simple representation of a table
class Table {
  final String tableName;
  final List<ColumnData> columns;

  String source = '';

  Table(this.tableName, this.columns);

  String get dartClassName => tableName.convertSnakeCaseToCamelCase().toUpperCaseFirst();

  @override
  String toString() {
    return 'Table(tableName: $tableName, columns: ${columns.length})';
  }
}

/// a simple representation of a column in a [Table]
class ColumnData {
  final String tableName;
  final String name;
  final String dataType;
  final bool isNullable;
  final bool isIdentity;
  final String? identityGeneration;
  final String? columnDefault;
  final bool useUtc;

  String get dartType => getDartType(dataType, isNullable);

  String get dartName => name.convertSnakeCaseToCamelCase();

  ColumnData._({
    required this.tableName,
    required this.name,
    required this.dataType,
    required this.isNullable,
    required this.isIdentity,
    required this.identityGeneration,
    required this.columnDefault,
    required this.useUtc,
  });

  factory ColumnData.fromMap(Map<String, dynamic> map, TypesGeneratorConfig config) {
    final tableName = map[InfoSchemaColumnNames.tableName] as String;
    final columnName = map[InfoSchemaColumnNames.columnName] as String;
    final dataType = map[InfoSchemaColumnNames.dataType] as String;
    // see discussion at: https://github.com/osaxma/schema-dart/issues/10#issuecomment-1891115948
    // TL;DR: used to determine if a class member should be nullable or not
    final isIdentity = map[InfoSchemaColumnNames.isIdentity].toLowerCase() == 'yes' ? true : false;
    final identityGeneration = map[InfoSchemaColumnNames.identityGeneration];
    final columnDefault = map[InfoSchemaColumnNames.columnDefault];
    final useUtc = config.useUtc;

    final bool isNullable;

    if (config.nullableFields ||
        (config.nullableIds && isIdentity && identityGeneration != null) ||
        config.nullableDefaults && columnDefault != null) {
      isNullable = true;
    } else {
      isNullable = (map[InfoSchemaColumnNames.isNullable].toLowerCase() == 'yes' ? true : false);
    }

    return ColumnData._(
      tableName: tableName,
      name: columnName,
      dataType: dataType,
      isNullable: isNullable,
      isIdentity: isIdentity,
      identityGeneration: identityGeneration,
      columnDefault: columnDefault,
      useUtc: useUtc,
    );
  }

  @override
  String toString() {
    return 'ColumnData(tableName: $tableName, columnName: $name, dataType: $dataType, isNullable: $isNullable)';
  }
}

/// Returns a String represneting a dart type from a [postgresType]
/// (i.e. `udt_name` from `information_schema.columns`)
// TODO: double check the types
//       The following was based on: https://github.com/SweetIQ/schemats/blob/master/src/schemaPostgres.ts
String getDartType(String postgresType, bool isNullable) {
  late final String dartType;
  switch (postgresType) {
    case 'bpchar':
    case 'char':
    case 'varchar':
    case 'text':
    case 'citext':
    case 'uuid':
    case 'inet':
    case 'time':
    case 'timetz':
    case 'interval':
    case 'name':
    // TODO: figure this one out -- postgres-dart returns it as a string for some reason
    case 'numeric':
      dartType = 'String';
      break;
    case 'bytea':
      dartType = 'List<int>';
      break;
    case 'int2':
    case 'int4':
    case 'int8':
    // Object Identifier Type
    // "The oid type is currently implemented as an unsigned four-byte integer."
    // - for more info, see: https://www.postgresql.org/docs/8.4/datatype-oid.html
    case 'oid':
      dartType = 'int';
      break;
    case 'float4':
    case 'float8':
    case 'money':
      dartType = 'double';
      break;
    case 'bool':
      dartType = 'bool';
      break;
    case 'json':
    case 'jsonb':
      dartType = 'Object'; // this can be different types (e.g. List or Map)
      break;
    case 'date':
    case 'timestamp':
    case 'timestamptz':
      dartType = 'DateTime';
      break;
    case '_int2':
    case '_int4':
    case '_int8':
      dartType = 'List<int>';
      break;
    case '_float4':
    case '_float8':
    case '_money':
      dartType = 'List<double>';
      break;
    case '_bool':
      dartType = 'List<bool>';
      break;
    case '_varchar':
    case '_text':
    case '_citext':
    case '_uuid':
    case '_bytea':
    // TODO: figure this one out -- postgres-dart returns it as a string for some reason
    case '_numeric':
      dartType = 'List<String>';
      break;
    case '_json':
    case '_jsonb':
      dartType = 'List<Object>'; // this can be different types (e.g. List<List> or List<Map>)
      break;
    case '_timestamptz':
      dartType = 'List<DateTime>';
      break;
    default:
      dartType = 'Object'; // or dynamic?
  }
  return dartType + (isNullable ? '?' : '');
}

class InfoSchemaColumnNames {
  static const tableName = 'table_name';
  static const columnName = 'column_name';
  static const dataType = 'udt_name'; // do not use `data_type` (see: NOTES.md)
  static const isNullable = 'is_nullable';
  static const isIdentity = 'is_identity';
  static const identityGeneration = 'identity_generation';
  static const columnDefault = 'column_default';

  static const all = [
    tableName,
    columnName,
    dataType,
    isNullable,
    isIdentity,
    identityGeneration,
    columnDefault,
  ];
}
