import 'package:curesee/admin/features/blog/core/network/admin_dio.dart';
import 'package:curesee/admin/features/blog/data/datasource/blog_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Baris 2 tombol kecil
        Row(
          children: [
            Expanded(
              child: _button("Hapus", Colors.red, () => _delete(context)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _button(
                "Batal",
                Colors.grey,
                () => Navigator.pop(context),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Tombol Simpan full lebar
        SizedBox(
          width: double.infinity,
          child: _button(
            "Simpan",
            const Color.fromARGB(255, 36, 84, 255),
            () => _save(context),
          ),
        ),
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
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          )
        ),  
      );
  }

  // ================= POPUP LOTTIE ANIMASI ==================
  Future<void> _showSuccessPopup(BuildContext context, String message) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          width: 180,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                "https://lottie.host/20ee79ea-4909-49fd-8bc4-195f497a8a42/XGskeXCCty.json",
                width: 120,
                height: 120,
                repeat: false,
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context); // tutup popup
  }

  // ================= DELETE ==================
  Future<void> _delete(BuildContext context) async {
    final dio = await AdminDio.getInstance();
    final ds = BlogRemoteDatasource(dio);

    await ds.deleteBlog(id);

    await _showSuccessPopup(context, "Berhasil dihapus");

    Navigator.pop(context); // balik halaman
  }

  // ================= SAVE ==================
  Future<void> _save(BuildContext context) async {
    final dio = await AdminDio.getInstance();
    final ds = BlogRemoteDatasource(dio);
    
    final data = FormData.fromMap({
      '_method': 'PATCH',
      'title': titleController.text,
      'content': descController.text,

      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath!),
    });

    await ds.updateBlog(id, data);

    await _showSuccessPopup(context, "Berhasil disimpan");

    Navigator.pop(context); // balik halaman
  }
}
