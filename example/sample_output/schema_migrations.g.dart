import 'dart:convert';

class SchemaMigrations {
  const SchemaMigrations({
    required this.version,
  });

  factory SchemaMigrations.fromMap(Map<String, dynamic> map) {
    return SchemaMigrations(
      version: map['version'],
    );
  }

  factory SchemaMigrations.fromJson(String source) => SchemaMigrations.fromMap(jsonDecode(source));

  final String version;

  SchemaMigrations copyWith({
    String? version,
  }) {
    return SchemaMigrations(
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
    };
  }

  String toJson() => jsonEncode(toMap());
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SchemaMigrations && other.version == version;
  }

  @override
  int get hashCode {
    return version.hashCode;
  }

  @override
  String toString() {
    return 'SchemaMigrations(version: $version)';
  }
}
