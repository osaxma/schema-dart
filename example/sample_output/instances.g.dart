import 'dart:convert';

class Instances {
  const Instances({
    this.updatedAt,
    this.uuid,
    required this.id,
    this.rawBaseConfig,
    this.createdAt,
  });

  factory Instances.fromMap(Map<String, dynamic> map) {
    return Instances(
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      uuid: map['uuid'],
      id: map['id'],
      rawBaseConfig: map['raw_base_config'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
    );
  }

  factory Instances.fromJson(String source) => Instances.fromMap(json.decode(source));

  final DateTime? updatedAt;

  final String? uuid;

  final String id;

  final String? rawBaseConfig;

  final DateTime? createdAt;

  Instances copyWith({
    DateTime? updatedAt,
    String? uuid,
    String? id,
    String? rawBaseConfig,
    DateTime? createdAt,
  }) {
    return Instances(
      updatedAt: updatedAt ?? this.updatedAt,
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      rawBaseConfig: rawBaseConfig ?? this.rawBaseConfig,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': updatedAt,
      'uuid': uuid,
      'id': id,
      'raw_base_config': rawBaseConfig,
      'created_at': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Instances &&
        other.updatedAt == updatedAt &&
        other.uuid == uuid &&
        other.id == id &&
        other.rawBaseConfig == rawBaseConfig &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return updatedAt.hashCode ^ uuid.hashCode ^ id.hashCode ^ rawBaseConfig.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Instances(updatedAt: $updatedAt, uuid: $uuid, id: $id, rawBaseConfig: $rawBaseConfig, createdAt: $createdAt)';
  }
}
