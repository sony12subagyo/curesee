class HistoryScan {
  final String id;
  final String userId;
  final String imagePath;
  final List<PredictionResult> predictions;
  final DateTime createdAt;

  HistoryScan({
    required this.id,
    required this.userId,
    required this.imagePath,
    required this.predictions,
    required this.createdAt,
  });
}

class PredictionResult {
  final String label;
  final double confidence;

  PredictionResult({
    required this.label,
    required this.confidence,
  });
}

