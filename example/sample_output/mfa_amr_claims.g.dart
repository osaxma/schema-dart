import 'dart:convert';

class MfaAmrClaims {
  const MfaAmrClaims({
    required this.updatedAt,
    required this.sessionId,
    required this.createdAt,
    required this.id,
    required this.authenticationMethod,
  });

  factory MfaAmrClaims.fromMap(Map<String, dynamic> map) {
    return MfaAmrClaims(
      updatedAt: DateTime.parse(map['updated_at']),
      sessionId: map['session_id'],
      createdAt: DateTime.parse(map['created_at']),
      id: map['id'],
      authenticationMethod: map['authentication_method'],
    );
  }

  factory MfaAmrClaims.fromJson(String source) => MfaAmrClaims.fromMap(json.decode(source));

  final DateTime updatedAt;

  final String sessionId;

  final DateTime createdAt;

  final String id;

  final String authenticationMethod;

  MfaAmrClaims copyWith({
    DateTime? updatedAt,
    String? sessionId,
    DateTime? createdAt,
    String? id,
    String? authenticationMethod,
  }) {
    return MfaAmrClaims(
      updatedAt: updatedAt ?? this.updatedAt,
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      authenticationMethod: authenticationMethod ?? this.authenticationMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'session_id': sessionId,
      'created_at': createdAt.toUtc().toIso8601String(),
      'id': id,
      'authentication_method': authenticationMethod,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MfaAmrClaims &&
        other.updatedAt == updatedAt &&
        other.sessionId == sessionId &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.authenticationMethod == authenticationMethod;
  }

  @override
  int get hashCode {
    return updatedAt.hashCode ^ sessionId.hashCode ^ createdAt.hashCode ^ id.hashCode ^ authenticationMethod.hashCode;
  }

  @override
  String toString() {
    return 'MfaAmrClaims(updatedAt: $updatedAt, sessionId: $sessionId, createdAt: $createdAt, id: $id, authenticationMethod: $authenticationMethod)';
  }
}
