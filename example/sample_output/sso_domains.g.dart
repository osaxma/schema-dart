import 'dart:convert';

class SsoDomains {
  const SsoDomains({
    required this.id,
    required this.domain,
    this.updatedAt,
    this.createdAt,
    required this.ssoProviderId,
  });

  factory SsoDomains.fromMap(Map<String, dynamic> map) {
    return SsoDomains(
      id: map['id'],
      domain: map['domain'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      ssoProviderId: map['sso_provider_id'],
    );
  }

  factory SsoDomains.fromJson(String source) => SsoDomains.fromMap(json.decode(source));

  final String id;

  final String domain;

  final DateTime? updatedAt;

  final DateTime? createdAt;

  final String ssoProviderId;

  SsoDomains copyWith({
    String? id,
    String? domain,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? ssoProviderId,
  }) {
    return SsoDomains(
      id: id ?? this.id,
      domain: domain ?? this.domain,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      ssoProviderId: ssoProviderId ?? this.ssoProviderId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'domain': domain,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'sso_provider_id': ssoProviderId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SsoDomains &&
        other.id == id &&
        other.domain == domain &&
        other.updatedAt == updatedAt &&
        other.createdAt == createdAt &&
        other.ssoProviderId == ssoProviderId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ domain.hashCode ^ updatedAt.hashCode ^ createdAt.hashCode ^ ssoProviderId.hashCode;
  }

  @override
  String toString() {
    return 'SsoDomains(id: $id, domain: $domain, updatedAt: $updatedAt, createdAt: $createdAt, ssoProviderId: $ssoProviderId)';
  }
}
