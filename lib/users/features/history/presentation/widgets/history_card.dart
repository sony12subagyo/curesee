import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatefulWidget {
  final String imagePath;
  final String label; 
  final double confidence;
  final DateTime createdAt;

  final VoidCallback onDelete;
  final VoidCallback onTap;


  const HistoryCard({
    super.key,
    required this.imagePath,
    required this.label,
    required this.confidence,
    required this.createdAt,
    required this.onDelete,
    required this.onTap,
  });

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  final bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // FIX: langsung format DateTime, ga usah lewat formatDate()
    final formattedDate =
        DateFormat("dd MMM yyyy • HH:mm").format(widget.createdAt);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1EA1E6),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(widget.imagePath),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 14),

              // INFO + TAP AREA
              Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${(widget.confidence * 100).toStringAsFixed(1)}% akurasi",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // DELETE BUTTON
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteDialog(context),
              ),
            ],
          ),

          // EXPANDED DETAIL
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildExpandedDetail(formattedDate),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // EXPANDED DETAIL
  Widget _buildExpandedDetail(String formattedDate) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              File(widget.imagePath),
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            widget.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Akurasi prediksi: ${(widget.confidence * 100).toStringAsFixed(2)}%",
            style: const TextStyle(fontSize: 15),
          ),

          const SizedBox(height: 6),

          Text(
            "Dibuat pada: $formattedDate",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

_showDeleteDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Hapus Data'),
      content: const Text('Apakah kamu yakin ingin menghapus data ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Hapus',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],    
    ),
  );
}
