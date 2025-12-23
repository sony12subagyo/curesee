import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import '../models/skin_detection_model.dart';

class MlKitImageDatasource {
  final ImageLabeler _labeler = ImageLabeler(
    options: ImageLabelerOptions(
      confidenceThreshold: 0.5,
    ),
  );

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
