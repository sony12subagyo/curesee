class EntityScanMl {
  final String disease;
  final double confidence;

  EntityScanMl({required this.disease, required this.confidence});

  EntityScanMl copyWith({String? disease, double? confidence}) {
    return EntityScanMl(
      disease: disease ?? this.disease,
      confidence: confidence ?? this.confidence,
    );
  }
}
