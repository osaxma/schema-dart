import 'dart:convert';

class Sessions {
  const Sessions({
    this.createdAt,
    this.userAgent,
    this.factorId,
    this.tag,
    this.ip,
    this.updatedAt,
    required this.id,
    required this.userId,
    this.refreshedAt,
    this.notAfter,
    this.aal,
  });

  factory Sessions.fromMap(Map<String, dynamic> map) {
    return Sessions(
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      userAgent: map['user_agent'],
      factorId: map['factor_id'],
      tag: map['tag'],
      ip: map['ip'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      id: map['id'],
      userId: map['user_id'],
      refreshedAt: DateTime.tryParse(map['refreshed_at'] ?? ""),
      notAfter: DateTime.tryParse(map['not_after'] ?? ""),
      aal: map['aal'],
    );
  }

  factory Sessions.fromJson(String source) => Sessions.fromMap(json.decode(source));

  final DateTime? createdAt;

  final String? userAgent;

  final String? factorId;

  final String? tag;

  final String? ip;

  final DateTime? updatedAt;

  final String id;

  final String userId;

  final DateTime? refreshedAt;

  final DateTime? notAfter;

  final Object? aal;

  Sessions copyWith({
    DateTime? createdAt,
    String? userAgent,
    String? factorId,
    String? tag,
    String? ip,
    DateTime? updatedAt,
    String? id,
    String? userId,
    DateTime? refreshedAt,
    DateTime? notAfter,
    Object? aal,
  }) {
    return Sessions(
      createdAt: createdAt ?? this.createdAt,
      userAgent: userAgent ?? this.userAgent,
      factorId: factorId ?? this.factorId,
      tag: tag ?? this.tag,
      ip: ip ?? this.ip,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      refreshedAt: refreshedAt ?? this.refreshedAt,
      notAfter: notAfter ?? this.notAfter,
      aal: aal ?? this.aal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'user_agent': userAgent,
      'factor_id': factorId,
      'tag': tag,
      'ip': ip,
      'updated_at': updatedAt,
      'id': id,
      'user_id': userId,
      'refreshed_at': refreshedAt,
      'not_after': notAfter,
      'aal': aal,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sessions &&
        other.createdAt == createdAt &&
        other.userAgent == userAgent &&
        other.factorId == factorId &&
        other.tag == tag &&
        other.ip == ip &&
        other.updatedAt == updatedAt &&
        other.id == id &&
        other.userId == userId &&
        other.refreshedAt == refreshedAt &&
        other.notAfter == notAfter &&
        other.aal == aal;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        userAgent.hashCode ^
        factorId.hashCode ^
        tag.hashCode ^
        ip.hashCode ^
        updatedAt.hashCode ^
        id.hashCode ^
        userId.hashCode ^
        refreshedAt.hashCode ^
        notAfter.hashCode ^
        aal.hashCode;
  }

  @override
  String toString() {
    return 'Sessions(createdAt: $createdAt, userAgent: $userAgent, factorId: $factorId, tag: $tag, ip: $ip, updatedAt: $updatedAt, id: $id, userId: $userId, refreshedAt: $refreshedAt, notAfter: $notAfter, aal: $aal)';
  }
}
