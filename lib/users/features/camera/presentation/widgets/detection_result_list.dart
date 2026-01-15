import 'package:flutter/material.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_descriptions.dart';
import 'package:curesee/users/features/skin_scane/domain/entities/skin_detection_entity.dart';

class DetectionResultList extends StatelessWidget {
  final SkinDetectionEntity result;

  const DetectionResultList({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hasil Scan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ...result.top3.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama + Persentase
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        d.label.toUpperCase(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${(d.confidence * 100).toStringAsFixed(1)}%",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Progress bar
                  LinearProgressIndicator(
                    value: d.confidence,
                    backgroundColor: Colors.grey[200],
                    color: Colors.blueAccent,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(6),
                  ),

                  const SizedBox(height: 6),

                  // Deskripsi
                  Text(
                    skinDescriptions[d.label] ?? "Tidak ada deskripsi.",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//menampilkan ringkasan hasil scan kulit