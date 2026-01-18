import 'package:curesee/users/features/history/presentation/widgets/history_detail_page.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/history_scan.dart';

class HistoryCard extends StatelessWidget {
  final HistoryScan scan;
  final VoidCallback onDelete;

  const HistoryCard({super.key, required this.scan, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    debugPrint("IMAGE URL => ${scan.imagePath}");

    final hasImage =
        scan.imagePath.isNotEmpty && scan.imagePath.startsWith("http");

    // Warna badge berdasarkan confidence (biar kelihatan "smart")
    final confidence = scan.predictions.first.confidence * 100;
    Color badgeColor;
    if (confidence < 50) {
      badgeColor = Colors.redAccent;
    } else if (confidence < 75) {
      badgeColor = Colors.orangeAccent;
    } else {
      badgeColor = Colors.green;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (_) => HistoryDetailPage(scan: scan)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 251, 255),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(31, 0, 102, 255),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // ========== IMAGE ==========
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 100,
                height: 100,
                child: hasImage
                    ? Hero(
                        tag: scan.id,
                        child: Image.network(
                          scan.imagePath,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 40),
                        ),
                      )
                    : const Icon(Icons.image_not_supported, size: 40),
              ),
            ),

            const SizedBox(width: 12),

            // ========== DATA ==========
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scan.predictions.first.label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ===== BADGE CONFIDENCE =====
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Confidence: ${confidence.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: badgeColor,
                        ),
                      ),
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

            // ========== DELETE ==========
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text("Hapus Riwayat?"),
                      content: const Text(
                        "Data scan ini akan dihapus permanen. "
                        "Apakah kamu yakin?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx); // tutup dialog
                          },
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.pop(ctx); // tutup dialog
                            onDelete(); // baru hapus data
                          },
                          child: const Text("Hapus"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
