import 'dart:convert';

class Identities {
  const Identities({
    this.updatedAt,
    required this.userId,
    this.lastSignInAt,
    required this.id,
    this.createdAt,
    required this.identityData,
    required this.provider,
  });

  factory Identities.fromMap(Map<String, dynamic> map) {
    return Identities(
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      userId: map['user_id'],
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at'] ?? ""),
      id: map['id'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      identityData: map['identity_data'],
      provider: map['provider'],
    );
  }

  factory Identities.fromJson(String source) => Identities.fromMap(json.decode(source));

  final DateTime? updatedAt;

  final String userId;

  final DateTime? lastSignInAt;

  final String id;

  final DateTime? createdAt;

  final Object identityData;

  final String provider;

  Identities copyWith({
    DateTime? updatedAt,
    String? userId,
    DateTime? lastSignInAt,
    String? id,
    DateTime? createdAt,
    Object? identityData,
    String? provider,
  }) {
    return Identities(
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      identityData: identityData ?? this.identityData,
      provider: provider ?? this.provider,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': updatedAt,
      'user_id': userId,
      'last_sign_in_at': lastSignInAt,
      'id': id,
      'created_at': createdAt,
      'identity_data': identityData,
      'provider': provider,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Identities &&
        other.updatedAt == updatedAt &&
        other.userId == userId &&
        other.lastSignInAt == lastSignInAt &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.identityData == identityData &&
        other.provider == provider;
  }

  @override
  int get hashCode {
    return updatedAt.hashCode ^
        userId.hashCode ^
        lastSignInAt.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        identityData.hashCode ^
        provider.hashCode;
  }

  @override
  String toString() {
    return 'Identities(updatedAt: $updatedAt, userId: $userId, lastSignInAt: $lastSignInAt, id: $id, createdAt: $createdAt, identityData: $identityData, provider: $provider)';
  }
}
