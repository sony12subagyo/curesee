class DiseasePrediction {
  final String label;
  final double confidence;

  DiseasePrediction(this.label, this.confidence);
}

class SkinDetectionEntity {
  final List<DiseasePrediction> top3;

  SkinDetectionEntity(this.top3);
}

//menyimpan hasil akhir analisis penyakit kulit yang akan ditampilkan ke pengguna