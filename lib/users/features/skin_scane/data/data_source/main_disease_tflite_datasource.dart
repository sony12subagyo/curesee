// import 'dart:io';
// import 'dart:math';
// import 'package:image/image.dart' as img;
// import 'package:tflite_flutter/tflite_flutter.dart';

// List<double> softmax(List<double> logits) {
//   final maxLogit = logits.reduce((a, b) => a > b ? a : b);
//   final exps = logits.map((x) => exp(x - maxLogit)).toList();
//   final sum = exps.reduce((a, b) => a + b);
//   return exps.map((x) => x / sum).toList();
// }

// class MainDiseaseTFLiteDatasource {
//   late Interpreter _interpreter;
//   bool _loaded = false;

//   final List<String> classNames = [
//     'dermatitis',
//     'eksim',
//     'acne',
//     'flek_hitam',
//     'herpes',
//     'melanoma',
//     'panu',
//     'psoriasis',
//     'rosacea',
//   ];

//   Future<void> load() async {
//     _interpreter = await Interpreter.fromAsset(
//       "assets/model/main_disease_finetuned.tflite",
//     );
//     _loaded = true;
//   }

//   Future<List<Map<String, Object>>> predictTop3(File imageFile) async {
//     if (!_loaded) await load();

//     // 1. Load image
//     // final raw = img.decodeImage(imageFile.readAsBytesSync())!;
//     //final raw = img.bgrToRgb(img.decodeImage(imageFile.readAsBytesSync())!);

//     img.Image convertBgrToRgb(img.Image src) {
//       final img.Image dst = img.Image(width: src.width, height: src.height);

//       for (int y = 0; y < src.height; y++) {
//         for (int x = 0; x < src.width; x++) {
//           final p = src.getPixel(x, y);
//           dst.setPixelRgb(x, y, p.b, p.g, p.r);
//         }
//       }
//       return dst;
//     }

//     final raw = convertBgrToRgb(img.decodeImage(imageFile.readAsBytesSync())!);

//     final resized = img.copyResize(raw, width: 224, height: 224);

//     // 2. Convert to input tensor
//     final input = List.generate(
//       1,
//       (_) => List.generate(
//         224,
//         (y) => List.generate(224, (x) {
//           final p = resized.getPixel(x, y);
//           return [p.r / 255.0, p.g / 255.0, p.b / 255.0];
//         }),
//       ),
//     );

//     // 3. CNN inference
//     final output = List.generate(1, (_) => List.filled(classNames.length, 0.0));
//     _interpreter.run(input, output);
//     //final cnnOutput = List<double>.from(output[0]);
//     final cnnOutput = softmax(List<double>.from(output[0]));
//     final maxConfidence = cnnOutput.reduce((a, b) => a > b ? a : b);

//     if (!isLikelySkin(resized) || maxConfidence < 0.40) {
//       return [
//         {"label": "bukan_kulit", "confidence": 1.0},
//       ];
//     }

//     // 4. Computer vision features
//     final features = extractFeatures(resized);
//     final redness = features["redness"]!;
//     final texture = features["texture"]!;
//     final darkness = features["darkness"]!;

//     // 5. Medical rules
//     final adjusted = applyMedicalRules(
//       cnnOutput,
//       classNames,
//       redness,
//       texture,
//       darkness,
//     );

//     // 6. Top-3
//     final sorted = adjusted.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));

//     return sorted
//         .take(3)
//         .map((e) => {"label": e.key, "confidence": e.value})
//         .toList();
//   }

//   // ================= IMAGE PROCESSING =================

//   Map<String, double> extractFeatures(img.Image image) {
//     double redness = 0;
//     double brightness = 0;
//     final List<int> gray = [];

//     for (int y = 0; y < image.height; y++) {
//       for (int x = 0; x < image.width; x++) {
//         final p = image.getPixel(x, y);
//         final r = p.r, g = p.g, b = p.b;

//         redness += r;
//         final grayVal = ((r + g + b) / 3).toInt();
//         brightness += grayVal;
//         gray.add(grayVal);
//       }
//     }

//     final total = image.width * image.height;
//     redness /= (total * 255);
//     //brightness /= total;
//     brightness = brightness / (total * 255);

//     final mean = gray.reduce((a, b) => a + b) / gray.length;
//     double variance = 0;
//     for (var v in gray) {
//       variance += (v - mean) * (v - mean);
//     }
//     variance /= gray.length;

//     return {"redness": redness, "texture": variance, "darkness": brightness};
//   }

//   // ================= MEDICAL RULES =================

//   Map<String, double> applyMedicalRules(
//     List<double> cnn,
//     List<String> labels,
//     double redness,
//     double texture,
//     double darkness,
//   ) {
//     final scores = <String, double>{};

//     for (int i = 0; i < labels.length; i++) {
//       scores[labels[i]] = cnn[i];
//     }

//     //if (darkness < 110) {
//     if (darkness < 0.45) {
//       scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) + 0.10;
//       scores["melanoma"] = (scores["melanoma"] ?? 0) + 0.05;
//       scores["rosacea"] = (scores["rosacea"] ?? 0) - 0.05;
//     }

//     if (redness > 0.55) {
//       scores["rosacea"] = (scores["rosacea"] ?? 0) + 0.10;
//       scores["eksim"] = (scores["eksim"] ?? 0) + 0.05;
//       scores["dermatitis"] = (scores["dermatitis"] ?? 0) + 0.05;
//       scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) - 0.05;
//     }

//     if (texture > 400) {
//       scores["eksim"] = (scores["eksim"] ?? 0) + 0.10;
//       scores["psoriasis"] = (scores["psoriasis"] ?? 0) + 0.10;
//       scores["acne"] = (scores["acne"] ?? 0) + 0.05;
//       scores["flek_hitam"] = (scores["flek_hitam"] ?? 0) - 0.05;
//     }

//     scores.updateAll((k, v) => v.clamp(0.0, 1.0));
//     return scores;
//   }
// }

// bool isLikelySkin(img.Image image) {
//   int skinPixels = 0;
//   final total = image.width * image.height;

//   for (int y = 0; y < image.height; y++) {
//     for (int x = 0; x < image.width; x++) {
//       final p = image.getPixel(x, y);
//       final r = p.r.toDouble();
//       final g = p.g.toDouble();
//       final b = p.b.toDouble();

//       final max = [r, g, b].reduce((a, b) => a > b ? a : b);
//       final min = [r, g, b].reduce((a, b) => a < b ? a : b);
//       final delta = max - min;

//       double h = 0;
//       if (delta != 0) {
//         if (max == r)
//           h = ((g - b) / delta) % 6;
//         else if (max == g)
//           h = ((b - r) / delta) + 2;
//         else
//           h = ((r - g) / delta) + 4;
//         h *= 60;
//         if (h < 0) h += 360;
//       }

//       final s = max == 0 ? 0 : delta / max;
//       final v = max / 255;

//       // HSV skin range (works on Android cameras)
//       if (h >= 0 && h <= 50 && s >= 0.23 && s <= 0.68 && v >= 0.35) {
//         skinPixels++;
//       }
//     }
//   }

//   final ratio = skinPixels / total;
//   return ratio > 0.04; // 4% already enough
// }


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
