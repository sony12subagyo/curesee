class DiseasePrediction {
  final String label;
  final double confidence;

  DiseasePrediction(this.label, this.confidence);
}

class SkinDetectionEntity {
  final List<DiseasePrediction> top3;

  SkinDetectionEntity(this.top3);
}
