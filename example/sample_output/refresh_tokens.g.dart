import 'dart:convert';

class RefreshTokens {
  const RefreshTokens({
    this.revoked,
    this.token,
    this.instanceId,
    this.parent,
    this.userId,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory RefreshTokens.fromMap(Map<String, dynamic> map) {
    return RefreshTokens(
      revoked: map['revoked'],
      token: map['token'],
      instanceId: map['instance_id'],
      parent: map['parent'],
      userId: map['user_id'],
      id: int.parse(map['id']),
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
    );
  }

  factory RefreshTokens.fromJson(String source) => RefreshTokens.fromMap(json.decode(source));

  final bool? revoked;

  final String? token;

  final String? instanceId;

  final String? parent;

  final String? userId;

  final int id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  RefreshTokens copyWith({
    bool? revoked,
    String? token,
    String? instanceId,
    String? parent,
    String? userId,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RefreshTokens(
      revoked: revoked ?? this.revoked,
      token: token ?? this.token,
      instanceId: instanceId ?? this.instanceId,
      parent: parent ?? this.parent,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'revoked': revoked,
      'token': token,
      'instance_id': instanceId,
      'parent': parent,
      'user_id': userId,
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshTokens &&
        other.revoked == revoked &&
        other.token == token &&
        other.instanceId == instanceId &&
        other.parent == parent &&
        other.userId == userId &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return revoked.hashCode ^
        token.hashCode ^
        instanceId.hashCode ^
        parent.hashCode ^
        userId.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'RefreshTokens(revoked: $revoked, token: $token, instanceId: $instanceId, parent: $parent, userId: $userId, id: $id, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
