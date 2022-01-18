import 'dart:convert';

class Identities {
  const Identities({
    required this.provider,
    required this.identityData,
    this.lastSignInAt,
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.userId,
  });

  factory Identities.fromMap(Map<String, dynamic> map) {
    return Identities(
      provider: map['provider'],
      identityData: map['identity_data'],
      lastSignInAt: DateTime.tryParse(map['last_sign_in_at']),
      id: map['id'],
      createdAt: DateTime.tryParse(map['created_at']),
      updatedAt: DateTime.tryParse(map['updated_at']),
      userId: map['user_id'],
    );
  }

  factory Identities.fromJson(String source) => Identities.fromMap(json.decode(source));

  final String provider;

  final Object identityData;

  final DateTime? lastSignInAt;

  final String id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String userId;

  Identities copyWith({
    String? provider,
    Object? identityData,
    DateTime? lastSignInAt,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Identities(
      provider: provider ?? this.provider,
      identityData: identityData ?? this.identityData,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'provider': provider,
      'identity_data': identityData,
      'last_sign_in_at': lastSignInAt,
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user_id': userId,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Identities &&
        other.provider == provider &&
        other.identityData == identityData &&
        other.lastSignInAt == lastSignInAt &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return provider.hashCode ^
        identityData.hashCode ^
        lastSignInAt.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode;
  }

  @override
  String toString() {
    return 'Identities(provider: $provider, identityData: $identityData, lastSignInAt: $lastSignInAt, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}
