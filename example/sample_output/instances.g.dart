import 'dart:convert';

class Instances {
  const Instances({
    this.updatedAt,
    required this.id,
    this.uuid,
    this.rawBaseConfig,
    this.createdAt,
  });

  factory Instances.fromMap(Map<String, dynamic> map) {
    return Instances(
      updatedAt: DateTime.tryParse(map['updated_at']),
      id: map['id'],
      uuid: map['uuid'],
      rawBaseConfig: map['raw_base_config'],
      createdAt: DateTime.tryParse(map['created_at']),
    );
  }

  factory Instances.fromJson(String source) => Instances.fromMap(json.decode(source));

  final DateTime? updatedAt;

  final String id;

  final String? uuid;

  final String? rawBaseConfig;

  final DateTime? createdAt;

  Instances copyWith({
    DateTime? updatedAt,
    String? id,
    String? uuid,
    String? rawBaseConfig,
    DateTime? createdAt,
  }) {
    return Instances(
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      rawBaseConfig: rawBaseConfig ?? this.rawBaseConfig,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': updatedAt,
      'id': id,
      'uuid': uuid,
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
        other.id == id &&
        other.uuid == uuid &&
        other.rawBaseConfig == rawBaseConfig &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return updatedAt.hashCode ^ id.hashCode ^ uuid.hashCode ^ rawBaseConfig.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Instances(updatedAt: $updatedAt, id: $id, uuid: $uuid, rawBaseConfig: $rawBaseConfig, createdAt: $createdAt)';
  }
}
