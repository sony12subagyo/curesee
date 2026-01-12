import 'package:flutter/material.dart';
import '../../domain/entities/history_scan.dart';

class HistoryDetailPage extends StatelessWidget {
  final HistoryScan scan;

  const HistoryDetailPage({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Scan"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 🔥 Pop dari ROOT navigator (bukan tab navigator)
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            if (scan.imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: scan.id, // HARUS sama dengan di HistoryCard
                  child: Image.network(
                    scan.imagePath,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Text(
              scan.predictions.first.label.toUpperCase(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Confidence: ${(scan.predictions.first.confidence * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              "Tanggal: ${scan.createdAt.toLocal().toString()}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
