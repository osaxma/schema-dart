import 'dart:convert';

class MfaFactors {
  const MfaFactors({
    required this.userId,
    this.friendlyName,
    this.secret,
    required this.updatedAt,
    required this.createdAt,
    required this.status,
    required this.factorType,
    required this.id,
  });

  factory MfaFactors.fromMap(Map<String, dynamic> map) {
    return MfaFactors(
      userId: map['user_id'],
      friendlyName: map['friendly_name'],
      secret: map['secret'],
      updatedAt: DateTime.parse(map['updated_at']),
      createdAt: DateTime.parse(map['created_at']),
      status: map['status'],
      factorType: map['factor_type'],
      id: map['id'],
    );
  }

  factory MfaFactors.fromJson(String source) => MfaFactors.fromMap(json.decode(source));

  final String userId;

  final String? friendlyName;

  final String? secret;

  final DateTime updatedAt;

  final DateTime createdAt;

  final Object status;

  final Object factorType;

  final String id;

  MfaFactors copyWith({
    String? userId,
    String? friendlyName,
    String? secret,
    DateTime? updatedAt,
    DateTime? createdAt,
    Object? status,
    Object? factorType,
    String? id,
  }) {
    return MfaFactors(
      userId: userId ?? this.userId,
      friendlyName: friendlyName ?? this.friendlyName,
      secret: secret ?? this.secret,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      factorType: factorType ?? this.factorType,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'friendly_name': friendlyName,
      'secret': secret,
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'created_at': createdAt.toUtc().toIso8601String(),
      'status': status,
      'factor_type': factorType,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MfaFactors &&
        other.userId == userId &&
        other.friendlyName == friendlyName &&
        other.secret == secret &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.status == status &&
        other.factorType == factorType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        friendlyName.hashCode ^
        secret.hashCode ^
        updatedAt.hashCode ^
        createdAt.hashCode ^
        status.hashCode ^
        factorType.hashCode ^
        id.hashCode;
  }

  @override
  String toString() {
    return 'MfaFactors(userId: $userId, friendlyName: $friendlyName, secret: $secret, updatedAt: $updatedAt, createdAt: $createdAt, status: $status, factorType: $factorType, id: $id)';
  }
}
