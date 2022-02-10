import 'dart:convert';

class Instances {
  const Instances({
    this.uuid,
    this.updatedAt,
    this.rawBaseConfig,
    required this.id,
    this.createdAt,
  });

  factory Instances.fromMap(Map<String, dynamic> map) {
    return Instances(
      uuid: map['uuid'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      rawBaseConfig: map['raw_base_config'],
      id: map['id'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
    );
  }

  factory Instances.fromJson(String source) => Instances.fromMap(jsonDecode(source));

  final String? uuid;

  final DateTime? updatedAt;

  final String? rawBaseConfig;

  final String id;

  final DateTime? createdAt;

  Instances copyWith({
    String? uuid,
    DateTime? updatedAt,
    String? rawBaseConfig,
    String? id,
    DateTime? createdAt,
  }) {
    return Instances(
      uuid: uuid ?? this.uuid,
      updatedAt: updatedAt ?? this.updatedAt,
      rawBaseConfig: rawBaseConfig ?? this.rawBaseConfig,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'updated_at': updatedAt,
      'raw_base_config': rawBaseConfig,
      'id': id,
      'created_at': createdAt,
    };
  }

  String toJson() => jsonEncode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Instances &&
        other.uuid == uuid &&
        other.updatedAt == updatedAt &&
        other.rawBaseConfig == rawBaseConfig &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^ updatedAt.hashCode ^ rawBaseConfig.hashCode ^ id.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Instances(uuid: $uuid, updatedAt: $updatedAt, rawBaseConfig: $rawBaseConfig, id: $id, createdAt: $createdAt)';
  }
}
