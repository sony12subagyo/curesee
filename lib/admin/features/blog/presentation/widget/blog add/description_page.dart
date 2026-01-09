import 'package:flutter/material.dart';

class BlogFormController {
  static final title = TextEditingController();
  static final description = TextEditingController();
}

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: BlogFormController.title,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: BlogFormController.description,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Deskripsi'),
          ),
        ],
      ),
    );
  }
}
