import 'dart:convert';

class SsoProviders {
  const SsoProviders({
    required this.id,
    this.resourceId,
    this.updatedAt,
    this.createdAt,
  });

  factory SsoProviders.fromMap(Map<String, dynamic> map) {
    return SsoProviders(
      id: map['id'],
      resourceId: map['resource_id'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
    );
  }

  factory SsoProviders.fromJson(String source) => SsoProviders.fromMap(json.decode(source));

  final String id;

  final String? resourceId;

  final DateTime? updatedAt;

  final DateTime? createdAt;

  SsoProviders copyWith({
    String? id,
    String? resourceId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return SsoProviders(
      id: id ?? this.id,
      resourceId: resourceId ?? this.resourceId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resource_id': resourceId,
      'updated_at': updatedAt,
      'created_at': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SsoProviders &&
        other.id == id &&
        other.resourceId == resourceId &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ resourceId.hashCode ^ updatedAt.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'SsoProviders(id: $id, resourceId: $resourceId, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}
