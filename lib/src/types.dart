import 'dart:convert';

class Table {
  final String tableName;
  final List<ColumnData> columns;

  Table(this.tableName, this.columns);
}

class ColumnData {
  final String tableName;
  final String columnName;
  final String dataType;
  final bool isNullable;
  ColumnData({
    required this.tableName,
    required this.columnName,
    required this.dataType,
    required this.isNullable,
  });

  Map<String, dynamic> toMap() {
    return {
      'tableName': tableName,
      'columnName': columnName,
      'dataType': dataType,
      'isNullable': isNullable,
    };
  }

  factory ColumnData.fromMap(Map<String, dynamic> map) {
    return ColumnData(
      tableName: map[InfoSchemaColumnNames.tableName],
      columnName: map[InfoSchemaColumnNames.columnName],
      dataType: map[InfoSchemaColumnNames.dataType],
      isNullable: map[InfoSchemaColumnNames.isNullable],
    );
  }

  String toJson() => json.encode(toMap());

  factory ColumnData.fromJson(String source) => ColumnData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ColumnData(tableName: $tableName, columnName: $columnName, dataType: $dataType, isNullable: $isNullable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColumnData &&
        other.tableName == tableName &&
        other.columnName == columnName &&
        other.dataType == dataType &&
        other.isNullable == isNullable;
  }

  @override
  int get hashCode {
    return tableName.hashCode ^ columnName.hashCode ^ dataType.hashCode ^ isNullable.hashCode;
  }
}

/// Returns a String represneting a dart based on a [postgresType]
/// (i.e. `udt_name` from `information_schema.columns`)
String getDartType(String postgresType, bool isNullable) {
  late final String dartType;
  // TODO: double check the types
  //       The following was copied and modified from here: https://github.com/SweetIQ/schemats/blob/master/src/schemaPostgres.ts
  switch (postgresType) {
    case 'bpchar':
    case 'char':
    case 'varchar':
    case 'text':
    case 'citext':
    case 'uuid':
    case 'bytea':
    case 'inet':
    case 'time':
    case 'timetz':
    case 'interval':
    case 'name':
      dartType = 'String';
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
    case 'numeric':
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
      dartType = 'List<num>';
      break;
    case '_float4':
    case '_float8':
    case '_numeric':
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
      isNullable = true; // since we don't know
      dartType = 'Object'; // or dynamic?
  }
  return dartType + (isNullable ? '?' : '');
}

class InfoSchemaColumnNames {
  static const tableName = 'table_name';
  static const columnName = 'column_name';
  static const dataType = 'udt_name'; // do not use `data_type` (see: NOTES.md)
  static const isNullable = 'is_nullable';
}
