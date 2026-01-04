import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class MainDiseaseTFLiteDatasource {
  late Interpreter _interpreter;
  bool _loaded = false;

  final List<String> classNames = [
    'dermatitis',
    'eksim',
    'acne',
    'flek_hitam',
    'herpes',
    'melanoma',
    'panu',
    'psoriasis',
    'rosacea',
  ];

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset(
      "assets/model/main_disease_finetuned.tflite",
    );
    _loaded = true;
  }

  Future<List<Map<String, Object>>> predictTop3(File imageFile) async {
    if (!_loaded) await load();

    // 1. Load image
    final raw = img.decodeImage(imageFile.readAsBytesSync())!;
    final resized = img.copyResize(raw, width: 224, height: 224);

    // 2. Convert to input tensor
    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final p = resized.getPixel(x, y);
          return [p.r / 255.0, p.g / 255.0, p.b / 255.0];
        }),
      ),
    );

    // 3. CNN inference
    final output = List.generate(1, (_) => List.filled(classNames.length, 0.0));
    _interpreter.run(input, output);
    final cnnOutput = List<double>.from(output[0]);

    // 4. Computer vision features
    final features = extractFeatures(resized);
    final redness = features["redness"]!;
    final texture = features["texture"]!;
    final darkness = features["darkness"]!;

    // 5. Medical rules
    final adjusted = applyMedicalRules(
      cnnOutput,
      classNames,
      redness,
      texture,
      darkness,
    );

    // 6. Top-3
    final sorted = adjusted.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted
        .take(3)
        .map((e) => {"label": e.key, "confidence": e.value})
        .toList();
  }

  // ================= IMAGE PROCESSING =================

  Map<String, double> extractFeatures(img.Image image) {
    double redness = 0;
    double brightness = 0;
    final List<int> gray = [];

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final p = image.getPixel(x, y);
        final r = p.r, g = p.g, b = p.b;

        redness += r;
        final grayVal = ((r + g + b) / 3).toInt();
        brightness += grayVal;
        gray.add(grayVal);
      }
    }

    final total = image.width * image.height;
    redness /= (total * 255);
    brightness /= total;

    final mean = gray.reduce((a, b) => a + b) / gray.length;
    double variance = 0;
    for (var v in gray) {
      variance += (v - mean) * (v - mean);
    }
    variance /= gray.length;

    return {"redness": redness, "texture": variance, "darkness": brightness};
  }

  // ================= MEDICAL RULES =================

  Map<String, double> applyMedicalRules(
    List<double> cnn,
    List<String> labels,
    double redness,
    double texture,
    double darkness,
  ) {
    final scores = <String, double>{};

    for (int i = 0; i < labels.length; i++) {
      scores[labels[i]] = cnn[i];
    }

    if (darkness < 110) {
      scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) + 0.10;
      scores["melanoma"] = (scores["melanoma"] ?? 0) + 0.05;
      scores["rosacea"] = (scores["rosacea"] ?? 0) - 0.05;
    }

    if (redness > 0.55) {
      scores["rosacea"] = (scores["rosacea"] ?? 0) + 0.10;
      scores["eksim"] = (scores["eksim"] ?? 0) + 0.05;
      scores["dermatitis"] = (scores["dermatitis"] ?? 0) + 0.05;
      scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) - 0.05;
    }

    if (texture > 400) {
      scores["eksim"] = (scores["eksim"] ?? 0) + 0.10;
      scores["psoriasis"] = (scores["psoriasis"] ?? 0) + 0.10;
      scores["acne"] = (scores["acne"] ?? 0) + 0.05;
      scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) - 0.05;
    }

    scores.updateAll((k, v) => v.clamp(0.0, 1.0));
    return scores;
  }
}
