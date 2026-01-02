import 'package:flutter/material.dart';

class CardEditBlog extends StatefulWidget {
  const CardEditBlog({super.key});

  @override
  State<CardEditBlog> createState() => _CardEditBlogState();
}

class _CardEditBlogState extends State<CardEditBlog> {
  bool isEditing = false;

  late TextEditingController titleController;
  late TextEditingController descController;

  // data awal (anggap dari backend)
  String title = 'Dermatitis Atopic (Eksim)';
  String description =
      'Eksim adalah kondisi kulit kronis yang menyebabkan kulit menjadi kering, gatal, dan meradang...';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: title);
    descController = TextEditingController(text: description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

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
                  title,
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
                  description,
                  style: const TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

          const SizedBox(height: 16),

          // ===== BUTTONS =====
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (isEditing) {
                      // SIMPAN
                      setState(() {
                        title = titleController.text;
                        description = descController.text;
                        isEditing = false;
                      });
                    } else {
                      // EDIT
                      setState(() {
                        isEditing = true;
                      });
                    }
                  },
                  child: Text(isEditing ? 'Simpan' : 'Edit'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    if (isEditing) {
                      // BATAL
                      setState(() {
                        titleController.text = title;
                        descController.text = description;
                        isEditing = false;
                      });
                    }
                  },
                  child: const Text('Batal'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
