import 'dart:convert';
import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/app/config/app_config.dart';

class HistoryScanModel extends HistoryScan {
  HistoryScanModel({
    required super.id,
    required super.userId,
    required super.imagePath,
    required super.predictions,
    required super.createdAt,
  });

  // ==========================
  // LOCAL (SQLite)
  // ==========================
  factory HistoryScanModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> predictionList =
        jsonDecode(map['predictions'] ?? "[]");

    return HistoryScanModel(
      id: map['id'].toString(),
      userId: map['userId'].toString(),
      imagePath: map['imagePath'] ?? "",
      predictions: predictionList.map((e) {
        return PredictionResult(
          label: e['label'] ?? "",
          confidence: (e['confidence'] as num?)?.toDouble() ?? 0.0,
        );
      }).toList(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'imagePath': imagePath,
      'predictions': jsonEncode(
        predictions
            .map((e) => {
                  'label': e.label,
                  'confidence': e.confidence,
                })
            .toList(),
      ),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ==========================
  // REMOTE (API)
  // ==========================
  factory HistoryScanModel.fromJson(Map<String, dynamic> json) {
    final rawPath = json['image_url'];

    String imageUrl = "";
    if (rawPath != null && rawPath.toString().isNotEmpty) {
      if (rawPath.toString().startsWith("http")) {
        imageUrl = rawPath.toString(); // sudah full URL
      } else {
        // baseUrl: https://xxxx.ngrok-free.app/api
        final base = AppConfig.baseUrl.replaceAll("/api", "");
        imageUrl = base + rawPath.toString(); // 🔥 jadi https://xxx/storage/...
      }
    }

    return HistoryScanModel(
      id: json['analyses_id'].toString(),
      userId: json['user_id'].toString(),
      imagePath: imageUrl,
      predictions: [
        PredictionResult(
          label: (json['result_text'] ?? "").toString(),
          confidence: double.tryParse(json['confidence_score'].toString()) ?? 0.0,
        ),
      ],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // ==========================
  // FROM ENTITY
  // ==========================
  factory HistoryScanModel.fromEntity(HistoryScan scan) {
    return HistoryScanModel(
      id: scan.id,
      userId: scan.userId,
      imagePath: scan.imagePath,
      predictions: scan.predictions,
      createdAt: scan.createdAt,
    );
  }

  // ==========================
  // TO JSON (POST ke backend)
  // ==========================
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'image_url': imagePath,
      'result_text': predictions.first.label,
      'confidence_score': predictions.first.confidence,
    };
  }
}
