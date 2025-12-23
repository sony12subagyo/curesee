class SkinDetectionModel {
  final String label;
  final double confidence;

  SkinDetectionModel({
    required this.label,
    required this.confidence,
  });

  @override
  String toString() {
    return 'SkinDetectionModel(label: $label, confidence: $confidence)';
  }
}
