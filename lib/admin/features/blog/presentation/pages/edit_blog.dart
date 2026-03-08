import 'package:curesee/admin/features/blog/presentation/widgets/blog%20edit/button_edit.dart';
import 'package:curesee/admin/features/blog/presentation/widgets/blog%20edit/card_edit_blog.dart';
import 'package:flutter/material.dart';

class EditBlogPage extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const EditBlogPage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  late TextEditingController titleController;
  late TextEditingController descController;

  String? newImagePath;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Blog",style: TextStyle(color: Colors.black),),),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CardEditBlog(
            titleController: titleController,
            descController: descController,
            imageUrl: widget.imageUrl,
            onImagePicked: (path) {
              newImagePath = path;
            },
          ),

          const SizedBox(height: 20),

          ButtonEdit(
            id: widget.id,
            titleController: titleController,
            descController: descController,
            imagePath: newImagePath,
          )
        ],
      ),
    );
  }
}
