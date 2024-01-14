import 'dart:convert';

class RefreshTokens {
  const RefreshTokens({
    this.createdAt,
    this.revoked,
    this.sessionId,
    this.parent,
    this.token,
    required this.id,
    this.userId,
    this.instanceId,
    this.updatedAt,
  });

  factory RefreshTokens.fromMap(Map<String, dynamic> map) {
    return RefreshTokens(
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      revoked: map['revoked'],
      sessionId: map['session_id'],
      parent: map['parent'],
      token: map['token'],
      id: int.parse(map['id']),
      userId: map['user_id'],
      instanceId: map['instance_id'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
    );
  }

  factory RefreshTokens.fromJson(String source) => RefreshTokens.fromMap(json.decode(source));

  final DateTime? createdAt;

  final bool? revoked;

  final String? sessionId;

  final String? parent;

  final String? token;

  final int id;

  final String? userId;

  final String? instanceId;

  final DateTime? updatedAt;

  RefreshTokens copyWith({
    DateTime? createdAt,
    bool? revoked,
    String? sessionId,
    String? parent,
    String? token,
    int? id,
    String? userId,
    String? instanceId,
    DateTime? updatedAt,
  }) {
    return RefreshTokens(
      createdAt: createdAt ?? this.createdAt,
      revoked: revoked ?? this.revoked,
      sessionId: sessionId ?? this.sessionId,
      parent: parent ?? this.parent,
      token: token ?? this.token,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      instanceId: instanceId ?? this.instanceId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'revoked': revoked,
      'session_id': sessionId,
      'parent': parent,
      'token': token,
      'id': id,
      'user_id': userId,
      'instance_id': instanceId,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshTokens &&
        other.createdAt == createdAt &&
        other.revoked == revoked &&
        other.sessionId == sessionId &&
        other.parent == parent &&
        other.token == token &&
        other.id == id &&
        other.userId == userId &&
        other.instanceId == instanceId &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        revoked.hashCode ^
        sessionId.hashCode ^
        parent.hashCode ^
        token.hashCode ^
        id.hashCode ^
        userId.hashCode ^
        instanceId.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'RefreshTokens(createdAt: $createdAt, revoked: $revoked, sessionId: $sessionId, parent: $parent, token: $token, id: $id, userId: $userId, instanceId: $instanceId, updatedAt: $updatedAt)';
  }
}
