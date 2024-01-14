import 'dart:convert';

class FlowState {
  const FlowState({
    this.createdAt,
    required this.codeChallengeMethod,
    this.userId,
    required this.id,
    required this.codeChallenge,
    this.providerRefreshToken,
    required this.providerType,
    this.providerAccessToken,
    required this.authCode,
    this.updatedAt,
    required this.authenticationMethod,
  });

  factory FlowState.fromMap(Map<String, dynamic> map) {
    return FlowState(
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      codeChallengeMethod: map['code_challenge_method'],
      userId: map['user_id'],
      id: map['id'],
      codeChallenge: map['code_challenge'],
      providerRefreshToken: map['provider_refresh_token'],
      providerType: map['provider_type'],
      providerAccessToken: map['provider_access_token'],
      authCode: map['auth_code'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      authenticationMethod: map['authentication_method'],
    );
  }

  factory FlowState.fromJson(String source) => FlowState.fromMap(json.decode(source));

  final DateTime? createdAt;

  final Object codeChallengeMethod;

  final String? userId;

  final String id;

  final String codeChallenge;

  final String? providerRefreshToken;

  final String providerType;

  final String? providerAccessToken;

  final String authCode;

  final DateTime? updatedAt;

  final String authenticationMethod;

  FlowState copyWith({
    DateTime? createdAt,
    Object? codeChallengeMethod,
    String? userId,
    String? id,
    String? codeChallenge,
    String? providerRefreshToken,
    String? providerType,
    String? providerAccessToken,
    String? authCode,
    DateTime? updatedAt,
    String? authenticationMethod,
  }) {
    return FlowState(
      createdAt: createdAt ?? this.createdAt,
      codeChallengeMethod: codeChallengeMethod ?? this.codeChallengeMethod,
      userId: userId ?? this.userId,
      id: id ?? this.id,
      codeChallenge: codeChallenge ?? this.codeChallenge,
      providerRefreshToken: providerRefreshToken ?? this.providerRefreshToken,
      providerType: providerType ?? this.providerType,
      providerAccessToken: providerAccessToken ?? this.providerAccessToken,
      authCode: authCode ?? this.authCode,
      updatedAt: updatedAt ?? this.updatedAt,
      authenticationMethod: authenticationMethod ?? this.authenticationMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'code_challenge_method': codeChallengeMethod,
      'user_id': userId,
      'id': id,
      'code_challenge': codeChallenge,
      'provider_refresh_token': providerRefreshToken,
      'provider_type': providerType,
      'provider_access_token': providerAccessToken,
      'auth_code': authCode,
      'updated_at': updatedAt,
      'authentication_method': authenticationMethod,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlowState &&
        other.createdAt == createdAt &&
        other.codeChallengeMethod == codeChallengeMethod &&
        other.userId == userId &&
        other.id == id &&
        other.codeChallenge == codeChallenge &&
        other.providerRefreshToken == providerRefreshToken &&
        other.providerType == providerType &&
        other.providerAccessToken == providerAccessToken &&
        other.authCode == authCode &&
        other.updatedAt == updatedAt &&
        other.authenticationMethod == authenticationMethod;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        codeChallengeMethod.hashCode ^
        userId.hashCode ^
        id.hashCode ^
        codeChallenge.hashCode ^
        providerRefreshToken.hashCode ^
        providerType.hashCode ^
        providerAccessToken.hashCode ^
        authCode.hashCode ^
        updatedAt.hashCode ^
        authenticationMethod.hashCode;
  }

  @override
  String toString() {
    return 'FlowState(createdAt: $createdAt, codeChallengeMethod: $codeChallengeMethod, userId: $userId, id: $id, codeChallenge: $codeChallenge, providerRefreshToken: $providerRefreshToken, providerType: $providerType, providerAccessToken: $providerAccessToken, authCode: $authCode, updatedAt: $updatedAt, authenticationMethod: $authenticationMethod)';
  }
}
