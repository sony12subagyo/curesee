import 'package:flutter/material.dart';

class InformationHeader extends StatelessWidget {
  const InformationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Information Detail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Admin dapat mengedit atau menghapus informasi.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
