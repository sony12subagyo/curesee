import 'package:curesee/users/features/history/presentation/widgets/history_detail_page.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/history_scan.dart';

class HistoryCard extends StatelessWidget {
  final HistoryScan scan;
  final VoidCallback onDelete;

  const HistoryCard({super.key, required this.scan, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    // Debug penting: pastikan URL benar
    debugPrint("IMAGE URL => ${scan.imagePath}");

    final hasImage =
        scan.imagePath.isNotEmpty && scan.imagePath.startsWith("http");

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HistoryDetailPage(scan: scan)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            // ================= IMAGE =================
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: hasImage
                    ? Image.network(
                        scan.imagePath,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint("❌ Image load failed: $error");
                          return const Icon(Icons.broken_image, size: 40);
                        },
                      )
                    : const Icon(Icons.image_not_supported, size: 40),
              ),
            ),

            const SizedBox(width: 12),

            // ================= DATA =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scan.predictions.first.label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Confidence: ${(scan.predictions.first.confidence * 100).toStringAsFixed(1)}%",
                      style: const TextStyle(fontSize: 13),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Scan: ${scan.createdAt.toLocal().toString().substring(0, 16)}",
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            // ================= DELETE =================
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
