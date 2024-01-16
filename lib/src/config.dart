class TypesGeneratorConfig {
  final bool generateCopyWith;
  final bool generateSerialization;
  final bool generateEquality;
  final bool generateToString;

  /// indicates that all fields of generated Class would be nullable
  ///
  /// `false` by default.
  final bool nullableFields;

  /// indicates that columns with `is_identit` == `true` && `identity_generation` != null
  /// will have nullable fields in the class
  ///
  /// `false` by default.
  final bool nullableIds;

  /// indicates that columns with `column_default` != `null` will be nullable
  ///
  /// `false` by default.
  final bool nullableDefaults;

  /// Indicates that all DateTime objects should be treated as UTC.
  final bool useUtc;

  const TypesGeneratorConfig({
    this.generateCopyWith = true,
    this.generateSerialization = true,
    this.generateEquality = true,
    this.generateToString = true,
    this.nullableFields = false,
    this.nullableIds = false,
    this.nullableDefaults = false,
    this.useUtc = false,
  });
}

class ClassOnlyConfig extends TypesGeneratorConfig {
  const ClassOnlyConfig()
      : super(
          generateCopyWith: false,
          generateEquality: false,
          generateSerialization: false,
          generateToString: false,
        );
}
