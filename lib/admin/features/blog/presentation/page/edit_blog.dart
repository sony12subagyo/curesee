import 'package:curesee/admin/features/blog/presentation/widget/blog%20edit/button_edit.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20edit/card_edit_blog.dart';
import 'package:flutter/material.dart';

class EditBlogPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const EditBlogPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FF),
      appBar: AppBar(
        title: const Text('Edit Information'),
        backgroundColor: const Color(0xFF1EA3FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SizedBox(height: 16),
            CardEditBlog(),
            SizedBox(height: 24),
            ButtonEdit(),
          ],
        ),
      ),
    );
  }
}
