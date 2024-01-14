import 'dart:convert';

class Identities {
  const Identities({
    this.updatedAt,
    this.createdAt,
    required this.provider,
    required this.userId,
    required this.identityData,
    this.lastSignInAt,
    required this.providerId,
    this.email,
    required this.id,
  });

  factory Identities.fromMap(Map<String, dynamic> map) {
    return Identities(
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      provider: map['provider'],
      userId: map['user_id'],
      identityData: map['identity_data'],
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at'] ?? ""),
      providerId: map['provider_id'],
      email: map['email'],
      id: map['id'],
    );
  }

  factory Identities.fromJson(String source) => Identities.fromMap(json.decode(source));

  final DateTime? updatedAt;

  final DateTime? createdAt;

  final String provider;

  final String userId;

  final Object identityData;

  final DateTime? lastSignInAt;

  final String providerId;

  final String? email;

  final String id;

  Identities copyWith({
    DateTime? updatedAt,
    DateTime? createdAt,
    String? provider,
    String? userId,
    Object? identityData,
    DateTime? lastSignInAt,
    String? providerId,
    String? email,
    String? id,
  }) {
    return Identities(
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      provider: provider ?? this.provider,
      userId: userId ?? this.userId,
      identityData: identityData ?? this.identityData,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      providerId: providerId ?? this.providerId,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'updated_at': updatedAt,
      'created_at': createdAt,
      'provider': provider,
      'user_id': userId,
      'identity_data': identityData,
      'last_sign_in_at': lastSignInAt,
      'provider_id': providerId,
      'email': email,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Identities &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.provider == provider &&
        other.userId == userId &&
        other.identityData == identityData &&
        other.lastSignInAt == lastSignInAt &&
        other.providerId == providerId &&
        other.email == email &&
        other.id == id;
  }

  @override
  int get hashCode {
    return updatedAt.hashCode ^
        createdAt.hashCode ^
        provider.hashCode ^
        userId.hashCode ^
        identityData.hashCode ^
        lastSignInAt.hashCode ^
        providerId.hashCode ^
        email.hashCode ^
        id.hashCode;
  }

  @override
  String toString() {
    return 'Identities(updatedAt: $updatedAt, createdAt: $createdAt, provider: $provider, userId: $userId, identityData: $identityData, lastSignInAt: $lastSignInAt, providerId: $providerId, email: $email, id: $id)';
  }
}
