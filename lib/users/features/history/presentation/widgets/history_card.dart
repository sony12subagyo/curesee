import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final VoidCallback onTap;

  const HistoryCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 150, 230),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Your skin is",
              style: TextStyle(
                color: Color.fromARGB(255, 31, 31, 31),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Times New Roman is a font type ......",
              style: TextStyle(color: Color.fromARGB(255, 46, 46, 46)),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "more",
                    style: TextStyle(
                      color: Color.fromARGB(255, 46, 46, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_right_alt,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
