import 'package:collection/collection.dart';
import 'dart:convert';

class SampleTable1 {
  const SampleTable1({
    this.id,
    this.issomething,
    this.listofbool,
    this.listofints,
    this.somedouble,
    this.dob,
    this.sometime,
    this.name,
    this.listofstrings,
  });

  factory SampleTable1.fromMap(Map<String, dynamic> map) {
    return SampleTable1(
      id: int.tryParse(map['id'] ?? ""),
      issomething: map['issomething'],
      listofbool: map['listofbool'] == null ? null : List<bool>.from(map['listofbool']),
      listofints: map['listofints'] == null ? null : List<int>.from(map['listofints']),
      somedouble: double.tryParse(map['somedouble'] ?? ""),
      dob: DateTime.tryParse(map['dob'] ?? ""),
      sometime: DateTime.tryParse(map['sometime'] ?? ""),
      name: map['name'],
      listofstrings: map['listofstrings'] == null ? null : List<String>.from(map['listofstrings']),
    );
  }

  factory SampleTable1.fromJson(String source) => SampleTable1.fromMap(json.decode(source));

  final int? id;

  final bool? issomething;

  final List<bool>? listofbool;

  final List<int>? listofints;

  final double? somedouble;

  final DateTime? dob;

  final DateTime? sometime;

  final String? name;

  final List<String>? listofstrings;

  SampleTable1 copyWith({
    int? id,
    bool? issomething,
    List<bool>? listofbool,
    List<int>? listofints,
    double? somedouble,
    DateTime? dob,
    DateTime? sometime,
    String? name,
    List<String>? listofstrings,
  }) {
    return SampleTable1(
      id: id ?? this.id,
      issomething: issomething ?? this.issomething,
      listofbool: listofbool ?? this.listofbool,
      listofints: listofints ?? this.listofints,
      somedouble: somedouble ?? this.somedouble,
      dob: dob ?? this.dob,
      sometime: sometime ?? this.sometime,
      name: name ?? this.name,
      listofstrings: listofstrings ?? this.listofstrings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issomething': issomething,
      'listofbool': listofbool,
      'listofints': listofints,
      'somedouble': somedouble,
      'dob': dob,
      'sometime': sometime,
      'name': name,
      'listofstrings': listofstrings,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final collectionEquals = const DeepCollectionEquality().equals;

    return other is SampleTable1 &&
        other.id == id &&
        other.issomething == issomething &&
        collectionEquals(other.listofbool, listofbool) &&
        collectionEquals(other.listofints, listofints) &&
        other.somedouble == somedouble &&
        other.dob == dob &&
        other.sometime == sometime &&
        other.name == name &&
        collectionEquals(other.listofstrings, listofstrings);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        issomething.hashCode ^
        listofbool.hashCode ^
        listofints.hashCode ^
        somedouble.hashCode ^
        dob.hashCode ^
        sometime.hashCode ^
        name.hashCode ^
        listofstrings.hashCode;
  }

  @override
  String toString() {
    return 'SampleTable1(id: $id, issomething: $issomething, listofbool: $listofbool, listofints: $listofints, somedouble: $somedouble, dob: $dob, sometime: $sometime, name: $name, listofstrings: $listofstrings)';
  }
}
