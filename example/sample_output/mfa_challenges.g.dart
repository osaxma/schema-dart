import 'dart:convert';

class MfaChallenges {
  const MfaChallenges({
    required this.ipAddress,
    required this.id,
    required this.factorId,
    required this.createdAt,
    this.verifiedAt,
  });

  factory MfaChallenges.fromMap(Map<String, dynamic> map) {
    return MfaChallenges(
      ipAddress: map['ip_address'],
      id: map['id'],
      factorId: map['factor_id'],
      createdAt: DateTime.parse(map['created_at']),
      verifiedAt: DateTime.tryParse(map['verified_at'] ?? ""),
    );
  }

  factory MfaChallenges.fromJson(String source) => MfaChallenges.fromMap(json.decode(source));

  final String ipAddress;

  final String id;

  final String factorId;

  final DateTime createdAt;

  final DateTime? verifiedAt;

  MfaChallenges copyWith({
    String? ipAddress,
    String? id,
    String? factorId,
    DateTime? createdAt,
    DateTime? verifiedAt,
  }) {
    return MfaChallenges(
      ipAddress: ipAddress ?? this.ipAddress,
      id: id ?? this.id,
      factorId: factorId ?? this.factorId,
      createdAt: createdAt ?? this.createdAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ip_address': ipAddress,
      'id': id,
      'factor_id': factorId,
      'created_at': createdAt.toUtc().toIso8601String(),
      'verified_at': verifiedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MfaChallenges &&
        other.ipAddress == ipAddress &&
        other.id == id &&
        other.factorId == factorId &&
        other.createdAt == createdAt &&
        other.verifiedAt == verifiedAt;
  }

  @override
  int get hashCode {
    return ipAddress.hashCode ^ id.hashCode ^ factorId.hashCode ^ createdAt.hashCode ^ verifiedAt.hashCode;
  }

  @override
  String toString() {
    return 'MfaChallenges(ipAddress: $ipAddress, id: $id, factorId: $factorId, createdAt: $createdAt, verifiedAt: $verifiedAt)';
  }
}
