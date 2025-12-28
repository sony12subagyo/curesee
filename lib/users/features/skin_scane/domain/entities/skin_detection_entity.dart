class SkinDetectionEntity {
  final String mainDisease;
  final double mainConfidence;
  final String? acneSubtype;
  final double? acneConfidence;

  const SkinDetectionEntity({
    required this.mainDisease,
    required this.mainConfidence,
    this.acneSubtype,
    this.acneConfidence,
  });
}
