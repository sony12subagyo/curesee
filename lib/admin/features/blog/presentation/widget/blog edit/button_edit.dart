import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ButtonEdit({
    super.key,

    required this.isEditing,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3.5, // kontrol tinggi tombol
      children: [
        _buildButton(text: 'Edit', onPressed: onEdit),

        _buildButton(
          text: 'Hapus',
          onPressed: () => _showDeleteDialog(context),
        ),
        _buildButton(
          text: 'Batal',
          backgroundColor: Colors.blue,
          onPressed: onCancel,
        ),
        _buildButton(text: 'Simpan', onPressed: onSave),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.blue,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Data'),
        content: const Text('Apakah kamu yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
