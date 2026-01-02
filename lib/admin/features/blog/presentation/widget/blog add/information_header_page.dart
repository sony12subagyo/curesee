import 'package:flutter/material.dart';

class InformationHeaderAdd extends StatelessWidget {
  final VoidCallback? onBack;

  const InformationHeaderAdd({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // ===== BACK BUTTON =====
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),

          const SizedBox(width: 8),

          // ===== TITLE =====
          const Text(
            'Add Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
