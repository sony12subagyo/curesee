import 'package:curesee/admin/features/blog/presentation/widget/blog%20edit/button_edit.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20edit/card_edit_blog.dart';
import 'package:flutter/material.dart';

class EditBlogPage extends StatefulWidget {
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
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  bool isEditing = false;

  late TextEditingController titleController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void onEdit() {
    setState(() => isEditing = true);
  }

  void onCancel() {
    setState(() {
      titleController.text = widget.title;
      descController.text = widget.description;
      isEditing = false;
    });
  }

  void onSave() {
    // 🔥 nanti di sini tinggal panggil API / Bloc
    setState(() => isEditing = false);
  }

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
          children: [
            CardEditBlog(
              isEditing: isEditing,
              titleController: titleController,
              descController: descController,
            ),

            const SizedBox(height: 24),

            ButtonEdit(
              isEditing: isEditing,
              onEdit: onEdit,
              onCancel: onCancel,
              onSave: onSave,
            ),
          ],
        ),
      ),
    );
  }
}
