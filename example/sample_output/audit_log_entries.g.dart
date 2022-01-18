import 'dart:convert';

class AuditLogEntries {
  const AuditLogEntries({
    this.payload,
    this.instanceId,
    this.createdAt,
    required this.id,
  });

  factory AuditLogEntries.fromMap(Map<String, dynamic> map) {
    return AuditLogEntries(
      payload: map['payload'],
      instanceId: map['instance_id'],
      createdAt: DateTime.tryParse(map['created_at']),
      id: map['id'],
    );
  }

  factory AuditLogEntries.fromJson(String source) => AuditLogEntries.fromMap(json.decode(source));

  final Object? payload;

  final String? instanceId;

  final DateTime? createdAt;

  final String id;

  AuditLogEntries copyWith({
    Object? payload,
    String? instanceId,
    DateTime? createdAt,
    String? id,
  }) {
    return AuditLogEntries(
      payload: payload ?? this.payload,
      instanceId: instanceId ?? this.instanceId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'payload': payload,
      'instance_id': instanceId,
      'created_at': createdAt,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuditLogEntries &&
        other.payload == payload &&
        other.instanceId == instanceId &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode {
    return payload.hashCode ^ instanceId.hashCode ^ createdAt.hashCode ^ id.hashCode;
  }

  @override
  String toString() {
    return 'AuditLogEntries(payload: $payload, instanceId: $instanceId, createdAt: $createdAt, id: $id)';
  }
}
