import 'dart:convert';

class SamlProviders {
  const SamlProviders({
    required this.ssoProviderId,
    this.createdAt,
    this.updatedAt,
    required this.id,
    this.metadataUrl,
    required this.metadataXml,
    required this.entityId,
    this.attributeMapping,
  });

  factory SamlProviders.fromMap(Map<String, dynamic> map) {
    return SamlProviders(
      ssoProviderId: map['sso_provider_id'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ""),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ""),
      id: map['id'],
      metadataUrl: map['metadata_url'],
      metadataXml: map['metadata_xml'],
      entityId: map['entity_id'],
      attributeMapping: map['attribute_mapping'],
    );
  }

  factory SamlProviders.fromJson(String source) => SamlProviders.fromMap(json.decode(source));

  final String ssoProviderId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String id;

  final String? metadataUrl;

  final String metadataXml;

  final String entityId;

  final Object? attributeMapping;

  SamlProviders copyWith({
    String? ssoProviderId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? id,
    String? metadataUrl,
    String? metadataXml,
    String? entityId,
    Object? attributeMapping,
  }) {
    return SamlProviders(
      ssoProviderId: ssoProviderId ?? this.ssoProviderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      metadataUrl: metadataUrl ?? this.metadataUrl,
      metadataXml: metadataXml ?? this.metadataXml,
      entityId: entityId ?? this.entityId,
      attributeMapping: attributeMapping ?? this.attributeMapping,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sso_provider_id': ssoProviderId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'id': id,
      'metadata_url': metadataUrl,
      'metadata_xml': metadataXml,
      'entity_id': entityId,
      'attribute_mapping': attributeMapping,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SamlProviders &&
        other.ssoProviderId == ssoProviderId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.id == id &&
        other.metadataUrl == metadataUrl &&
        other.metadataXml == metadataXml &&
        other.entityId == entityId &&
        other.attributeMapping == attributeMapping;
  }

  @override
  int get hashCode {
    return ssoProviderId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        id.hashCode ^
        metadataUrl.hashCode ^
        metadataXml.hashCode ^
        entityId.hashCode ^
        attributeMapping.hashCode;
  }

  @override
  String toString() {
    return 'SamlProviders(ssoProviderId: $ssoProviderId, createdAt: $createdAt, updatedAt: $updatedAt, id: $id, metadataUrl: $metadataUrl, metadataXml: $metadataXml, entityId: $entityId, attributeMapping: $attributeMapping)';
  }
}
