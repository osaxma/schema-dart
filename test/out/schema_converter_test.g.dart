import 'package:collection/collection.dart';
import 'dart:convert';

class SchemaConverterTest {
  const SchemaConverterTest({
    this.id,
    this.issomething,
    this.name,
    this.somedouble,
    this.dob,
    this.sometime,
    this.listofbool,
    this.listofints,
    this.listofstrings,
  });

  factory SchemaConverterTest.fromMap(Map<String, dynamic> map) {
    return SchemaConverterTest(
      id: map['id']?.toInt(),
      issomething: map['issomething'],
      name: map['name'],
      somedouble: map['somedouble']?.toDouble(),
      dob: DateTime.tryParse(map['dob'] ?? ""),
      sometime: DateTime.tryParse(map['sometime'] ?? ""),
      listofbool: map['listofbool'] == null ? null : List<bool>.from(map['listofbool']),
      listofints: map['listofints'] == null ? null : List<int>.from(map['listofints']),
      listofstrings: map['listofstrings'] == null ? null : List<String>.from(map['listofstrings']),
    );
  }

  factory SchemaConverterTest.fromJson(String source) => SchemaConverterTest.fromMap(json.decode(source));

  final int? id;

  final bool? issomething;

  final String? name;

  final double? somedouble;

  final DateTime? dob;

  final DateTime? sometime;

  final List<bool>? listofbool;

  final List<int>? listofints;

  final List<String>? listofstrings;

  SchemaConverterTest copyWith({
    int? id,
    bool? issomething,
    String? name,
    double? somedouble,
    DateTime? dob,
    DateTime? sometime,
    List<bool>? listofbool,
    List<int>? listofints,
    List<String>? listofstrings,
  }) {
    return SchemaConverterTest(
      id: id ?? this.id,
      issomething: issomething ?? this.issomething,
      name: name ?? this.name,
      somedouble: somedouble ?? this.somedouble,
      dob: dob ?? this.dob,
      sometime: sometime ?? this.sometime,
      listofbool: listofbool ?? this.listofbool,
      listofints: listofints ?? this.listofints,
      listofstrings: listofstrings ?? this.listofstrings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issomething': issomething,
      'name': name,
      'somedouble': somedouble,
      'dob': dob?.toIso8601String(),
      'sometime': sometime?.toIso8601String(),
      'listofbool': listofbool,
      'listofints': listofints,
      'listofstrings': listofstrings,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is SchemaConverterTest &&
        other.id == id &&
        other.issomething == issomething &&
        other.name == name &&
        other.somedouble == somedouble &&
        other.dob == dob &&
        other.sometime == sometime &&
        collectionEquals(other.listofbool, listofbool) &&
        collectionEquals(other.listofints, listofints) &&
        collectionEquals(other.listofstrings, listofstrings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        issomething.hashCode ^
        name.hashCode ^
        somedouble.hashCode ^
        dob.hashCode ^
        sometime.hashCode ^
        listofbool.hashCode ^
        listofints.hashCode ^
        listofstrings.hashCode;
  }

  @override
  String toString() {
    return 'SchemaConverterTest(id: $id, issomething: $issomething, name: $name, somedouble: $somedouble, dob: $dob, sometime: $sometime, listofbool: $listofbool, listofints: $listofints, listofstrings: $listofstrings)';
  }
}
