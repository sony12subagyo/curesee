import 'package:flutter/material.dart';

class InformationHeaderAdd extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const InformationHeaderAdd({
    super.key,
    this.title = 'INFORMATION',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
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
