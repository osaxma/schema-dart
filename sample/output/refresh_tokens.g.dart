import 'dart:convert';

class RefreshTokens {
  const RefreshTokens({
    this.instanceId,
    this.userId,
    required this.id,
    this.createdAt,
    this.revoked,
    this.updatedAt,
    this.parent,
    this.token,
  });

  factory RefreshTokens.fromMap(Map<String, dynamic> map) {
    return RefreshTokens(
      instanceId: map['instance_id'],
      userId: map['user_id'],
      id: int.parse(map['id']),
      createdAt: DateTime.tryParse(map['created_at']),
      revoked: map['revoked'],
      updatedAt: DateTime.tryParse(map['updated_at']),
      parent: map['parent'],
      token: map['token'],
    );
  }

  factory RefreshTokens.fromJson(String source) => RefreshTokens.fromMap(json.decode(source));

  final String? instanceId;

  final String? userId;

  final int id;

  final DateTime? createdAt;

  final bool? revoked;

  final DateTime? updatedAt;

  final String? parent;

  final String? token;

  RefreshTokens copyWith({
    String? instanceId,
    String? userId,
    int? id,
    DateTime? createdAt,
    bool? revoked,
    DateTime? updatedAt,
    String? parent,
    String? token,
  }) {
    return RefreshTokens(
      instanceId: instanceId ?? this.instanceId,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      revoked: revoked ?? this.revoked,
      updatedAt: updatedAt ?? this.updatedAt,
      parent: parent ?? this.parent,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'instance_id': instanceId,
      'user_id': userId,
      'id': id,
      'created_at': createdAt,
      'revoked': revoked,
      'updated_at': updatedAt,
      'parent': parent,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshTokens &&
        other.instanceId == instanceId &&
        other.userId == userId &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.revoked == revoked &&
        other.updatedAt == updatedAt &&
        other.parent == parent &&
        other.token == token;
  }

  @override
  int get hashCode {
    return instanceId.hashCode ^
        userId.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        revoked.hashCode ^
        updatedAt.hashCode ^
        parent.hashCode ^
        token.hashCode;
  }

  @override
  String toString() {
    return 'RefreshTokens(instanceId: $instanceId, userId: $userId, id: $id, createdAt: $createdAt, revoked: $revoked, updatedAt: $updatedAt, parent: $parent, token: $token)';
  }
}
