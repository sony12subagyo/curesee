import 'dart:convert';
import 'package:curesee/users/features/history/domain/entities/history_scan.dart';

class HistoryScanModel extends HistoryScan {
  HistoryScanModel({
    required super.id,
    required super.imagePath,
    required super.predictions,
    required super.createdAt,
  });

  /// Convert Map(SQLite row) → Model
  factory HistoryScanModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> predictionList = jsonDecode(map['predictions']);

    return HistoryScanModel(
      id: map['id'],
      imagePath: map['imagePath'],
      predictions: predictionList.map((e) {
        return PredictionResult(label: e['label'], confidence: e['confidence']);
      }).toList(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  /// Convert Model → Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'predictions': jsonEncode(
        predictions
            .map((e) => {'label': e.label, 'confidence': e.confidence})
            .toList(),
      ),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
