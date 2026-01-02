import 'package:flutter/material.dart';

class CardEditBlog extends StatelessWidget {
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController descController;

  const CardEditBlog({
    super.key,
    required this.isEditing,
    required this.titleController,
    required this.descController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://picsum.photos/400/200',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // ===== TITLE =====
          isEditing
              ? TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  titleController.text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

          const SizedBox(height: 8),

          // ===== DESCRIPTION =====
          isEditing
              ? TextField(
                  controller: descController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                )
              : Text(
                  descController.text,
                  style: const TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
        ],
      ),
    );
  }
}
