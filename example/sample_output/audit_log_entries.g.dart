import 'dart:convert';

class AuditLogEntries {
  const AuditLogEntries({
    this.instanceId,
    required this.id,
    required this.ipAddress,
    this.payload,
    this.createdAt,
  });

  factory AuditLogEntries.fromMap(Map<String, dynamic> map) {
    return AuditLogEntries(
      instanceId: map['instance_id'],
      id: map['id'],
      ipAddress: map['ip_address'],
      payload: map['payload'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
    );
  }

  factory AuditLogEntries.fromJson(String source) => AuditLogEntries.fromMap(json.decode(source));

  final String? instanceId;

  final String id;

  final String ipAddress;

  final Object? payload;

  final DateTime? createdAt;

  AuditLogEntries copyWith({
    String? instanceId,
    String? id,
    String? ipAddress,
    Object? payload,
    DateTime? createdAt,
  }) {
    return AuditLogEntries(
      instanceId: instanceId ?? this.instanceId,
      id: id ?? this.id,
      ipAddress: ipAddress ?? this.ipAddress,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'instance_id': instanceId,
      'id': id,
      'ip_address': ipAddress,
      'payload': payload,
      'created_at': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuditLogEntries &&
        other.instanceId == instanceId &&
        other.id == id &&
        other.ipAddress == ipAddress &&
        other.payload == payload &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return instanceId.hashCode ^ id.hashCode ^ ipAddress.hashCode ^ payload.hashCode ^ createdAt.hashCode;
  }

  @override
  String toString() {
    return 'AuditLogEntries(instanceId: $instanceId, id: $id, ipAddress: $ipAddress, payload: $payload, createdAt: $createdAt)';
  }
}
