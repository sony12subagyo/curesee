import 'package:curesee/admin/features/blog/presentation/widget/button_edit.dart';
import 'package:curesee/admin/features/blog/presentation/widget/card_edit_blog.dart';
import 'package:flutter/material.dart';
import '../widget/information_header.dart';


class EditBlogPage extends StatelessWidget {
  const EditBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1FF),
      appBar: AppBar(
        title: const Text('Detail Information'),
        backgroundColor: const Color(0xFF1EA3FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            InformationHeader(),
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
