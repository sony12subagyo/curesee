import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardEditBlog extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final String imageUrl;
  final Function(String path) onImagePicked;

  const CardEditBlog({
    super.key,
    required this.titleController,
    required this.descController,
    required this.imageUrl,
    required this.onImagePicked,
  });

  @override
  State<CardEditBlog> createState() => _CardEditBlogState();
}

class _CardEditBlogState extends State<CardEditBlog> {
  bool isEditing = true;
  String? localImage;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => localImage = file.path);
      widget.onImagePicked(file.path);
    }
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
          GestureDetector(
            onTap: pickImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: localImage != null
                  ? Image.file(File(localImage!), height: 160, width: double.infinity, fit: BoxFit.cover)
                  : Image.network(widget.imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: widget.titleController,
            decoration: const InputDecoration(labelText: 'Judul', border: OutlineInputBorder()),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: widget.descController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
