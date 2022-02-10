import 'dart:convert';

class AuditLogEntries {
  const AuditLogEntries({
    this.createdAt,
    required this.id,
    this.instanceId,
    this.payload,
  });

  factory AuditLogEntries.fromMap(Map<String, dynamic> map) {
    return AuditLogEntries(
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      id: map['id'],
      instanceId: map['instance_id'],
      payload: map['payload'],
    );
  }

  factory AuditLogEntries.fromJson(String source) => AuditLogEntries.fromMap(jsonDecode(source));

  final DateTime? createdAt;

  final String id;

  final String? instanceId;

  final Object? payload;

  AuditLogEntries copyWith({
    DateTime? createdAt,
    String? id,
    String? instanceId,
    Object? payload,
  }) {
    return AuditLogEntries(
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      instanceId: instanceId ?? this.instanceId,
      payload: payload ?? this.payload,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'created_at': createdAt,
      'id': id,
      'instance_id': instanceId,
      'payload': payload,
    };
  }

  String toJson() => jsonEncode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuditLogEntries &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.instanceId == instanceId &&
        other.payload == payload;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^ id.hashCode ^ instanceId.hashCode ^ payload.hashCode;
  }

  @override
  String toString() {
    return 'AuditLogEntries(createdAt: $createdAt, id: $id, instanceId: $instanceId, payload: $payload)';
  }
}
