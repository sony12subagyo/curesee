import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import '../models/skin_detection_model.dart';

class MlKitCustomModelDatasource {
  late final ImageLabeler _labeler;

  MlKitCustomModelDatasource() {
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.3,
      modelPath: 'assets/model/dermnet_model_optimized.tflite',
    );

    _labeler = ImageLabeler(options: options);
  }

  Future<List<SkinDetectionModel>> detectSkin(File image) async {
    final inputImage = InputImage.fromFile(image);
    final labels = await _labeler.processImage(inputImage);

    return labels.map((label) {
      return SkinDetectionModel(
        label: label.label.toLowerCase(),
        confidence: label.confidence,
      );
    }).toList();
  }

  void dispose() {
    _labeler.close();
  }
}
