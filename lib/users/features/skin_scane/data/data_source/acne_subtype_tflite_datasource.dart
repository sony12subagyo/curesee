import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class AcneSubtypeTFLiteDatasource {
  late Interpreter _interpreter;

  final labels = [
    "whitehead",
    "blackhead",
    "papula",
    "pustula",
    "nodules",
    "fulminans",
  ];

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset(
      'assets/model/acne_subtype.tflite',
    );
  }

  Future<Map<String, dynamic>> predict(File imageFile) async {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final resized = img.copyResize(image, width: 224, height: 224);

    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = resized.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }),
      ),
    );

    final output = List.filled(
      1 * labels.length,
      0.0,
    ).reshape([1, labels.length]);

    _interpreter.run(input, output);

    int bestIndex = 0;
    double bestScore = 0;

    for (int i = 0; i < labels.length; i++) {
      if (output[0][i] > bestScore) {
        bestScore = output[0][i];
        bestIndex = i;
      }
    }

    return {"label": labels[bestIndex], "confidence": bestScore};
  }
}
