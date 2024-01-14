import 'dart:convert';

class SamlRelayStates {
  const SamlRelayStates({
    this.flowStateId,
    required this.id,
    required this.ssoProviderId,
    this.fromIpAddress,
    this.createdAt,
    this.updatedAt,
    this.redirectTo,
    required this.requestId,
    this.forEmail,
  });

  factory SamlRelayStates.fromMap(Map<String, dynamic> map) {
    return SamlRelayStates(
      flowStateId: map['flow_state_id'],
      id: map['id'],
      ssoProviderId: map['sso_provider_id'],
      fromIpAddress: map['from_ip_address'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      redirectTo: map['redirect_to'],
      requestId: map['request_id'],
      forEmail: map['for_email'],
    );
  }

  factory SamlRelayStates.fromJson(String source) => SamlRelayStates.fromMap(json.decode(source));

  final String? flowStateId;

  final String id;

  final String ssoProviderId;

  final String? fromIpAddress;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String? redirectTo;

  final String requestId;

  final String? forEmail;

  SamlRelayStates copyWith({
    String? flowStateId,
    String? id,
    String? ssoProviderId,
    String? fromIpAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? redirectTo,
    String? requestId,
    String? forEmail,
  }) {
    return SamlRelayStates(
      flowStateId: flowStateId ?? this.flowStateId,
      id: id ?? this.id,
      ssoProviderId: ssoProviderId ?? this.ssoProviderId,
      fromIpAddress: fromIpAddress ?? this.fromIpAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      redirectTo: redirectTo ?? this.redirectTo,
      requestId: requestId ?? this.requestId,
      forEmail: forEmail ?? this.forEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flow_state_id': flowStateId,
      'id': id,
      'sso_provider_id': ssoProviderId,
      'from_ip_address': fromIpAddress,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'redirect_to': redirectTo,
      'request_id': requestId,
      'for_email': forEmail,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SamlRelayStates &&
        other.flowStateId == flowStateId &&
        other.id == id &&
        other.ssoProviderId == ssoProviderId &&
        other.fromIpAddress == fromIpAddress &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.redirectTo == redirectTo &&
        other.requestId == requestId &&
        other.forEmail == forEmail;
  }

  @override
  int get hashCode {
    return flowStateId.hashCode ^
        id.hashCode ^
        ssoProviderId.hashCode ^
        fromIpAddress.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        redirectTo.hashCode ^
        requestId.hashCode ^
        forEmail.hashCode;
  }

  @override
  String toString() {
    return 'SamlRelayStates(flowStateId: $flowStateId, id: $id, ssoProviderId: $ssoProviderId, fromIpAddress: $fromIpAddress, createdAt: $createdAt, updatedAt: $updatedAt, redirectTo: $redirectTo, requestId: $requestId, forEmail: $forEmail)';
  }
}
