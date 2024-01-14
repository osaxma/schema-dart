import 'dart:convert';

class SampleTable1 {
  const SampleTable1({
    this.id,
    this.issomething,
    this.somedouble,
    this.dob,
    this.sometime,
    this.name,
  });

  factory SampleTable1.fromMap(Map<String, dynamic> map) {
    return SampleTable1(
      id: int.tryParse(map['id'] ?? ""),
      issomething: map['issomething'],
      somedouble: double.tryParse(map['somedouble'] ?? ""),
      dob: DateTime.tryParse(map['dob'] ?? ""),
      sometime: DateTime.tryParse(map['sometime'] ?? ""),
      name: map['name'],
    );
  }

  factory SampleTable1.fromJson(String source) => SampleTable1.fromMap(json.decode(source));

  final int? id;

  final bool? issomething;

  final double? somedouble;

  final DateTime? dob;

  final DateTime? sometime;

  final String? name;

  SampleTable1 copyWith({
    int? id,
    bool? issomething,
    double? somedouble,
    DateTime? dob,
    DateTime? sometime,
    String? name,
  }) {
    return SampleTable1(
      id: id ?? this.id,
      issomething: issomething ?? this.issomething,
      somedouble: somedouble ?? this.somedouble,
      dob: dob ?? this.dob,
      sometime: sometime ?? this.sometime,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issomething': issomething,
      'somedouble': somedouble,
      'dob': dob,
      'sometime': sometime,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SampleTable1 &&
        other.id == id &&
        other.issomething == issomething &&
        other.somedouble == somedouble &&
        other.dob == dob &&
        other.sometime == sometime &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ issomething.hashCode ^ somedouble.hashCode ^ dob.hashCode ^ sometime.hashCode ^ name.hashCode;
  }

  @override
  String toString() {
    return 'SampleTable1(id: $id, issomething: $issomething, somedouble: $somedouble, dob: $dob, sometime: $sometime, name: $name)';
  }
}
