import 'package:curesee/admin/features/blog/core/network/admin_dio.dart';
import 'package:curesee/admin/features/blog/data/datasource/blog_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  final int id;
  final TextEditingController titleController;
  final TextEditingController descController;
  final String? imagePath;

  const ButtonEdit({
    super.key,
    required this.id,
    required this.titleController,
    required this.descController,
    required this.imagePath,
  });

  @override

  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3.5,
      children: [
        _button("Hapus", Colors.red, () => _delete(context)),
        _button("Batal", Colors.grey, () => Navigator.pop(context)),
        _button("Simpan", Colors.green, () => _save(context)),
      ],
    );
  }
  Widget _button(String text, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
  // ================= DELETE ==================
  Future<void> _delete(BuildContext context) async {
    final dio = await AdminDio.getInstance();
    final ds = BlogRemoteDatasource(dio);

    await ds.deleteBlog(id);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Berhasil dihapus")));

    Navigator.pop(context);
  }

  Future<void> _save(BuildContext context) async {
    final dio = await AdminDio.getInstance();
    final ds = BlogRemoteDatasource(dio);

    final data = FormData.fromMap({
      '_method': 'PATCH',
      'title': titleController.text,
      'content': descController.text,
      if (imagePath != null)
        'image': await MultipartFile.fromFile(imagePath!),
    });

    await ds.updateBlog(id, data);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Perubahan disimpan")));

    Navigator.pop(context);
  }
}
