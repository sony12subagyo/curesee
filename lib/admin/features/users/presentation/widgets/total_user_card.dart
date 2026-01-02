import 'package:flutter/material.dart';

class TotalUserCard extends StatelessWidget {
  final int totalUser;

  const TotalUserCard({super.key, required this.totalUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.people, size: 32),
          const SizedBox(width: 12),
          Text(
            '$totalUser Pengguna',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
