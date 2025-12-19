import 'package:flutter/material.dart';

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              maxLines: null,
              decoration: const InputDecoration(
                icon: Icon(Icons.edit, color: Colors.grey),
                hintText: 'Add information about skin here',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
