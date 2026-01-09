class PredictionResult {
  final String label;
  final double confidence;

  PredictionResult({required this.label, required this.confidence});
}

class HistoryScan {
  final String id;
  final String imagePath;
  final List<PredictionResult> predictions;
  final DateTime createdAt;

  HistoryScan({
    required this.id,
    required this.imagePath,
    required this.predictions,
    required this.createdAt,
  });
}
