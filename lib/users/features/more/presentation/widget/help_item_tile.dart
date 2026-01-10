import 'package:flutter/material.dart';

class HelpItemTile extends StatefulWidget {
  final String title;
  final String answer;

  const HelpItemTile({super.key, required this.title, required this.answer});

  @override
  State<HelpItemTile> createState() => _HelpItemTileState();
}

class _HelpItemTileState extends State<HelpItemTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(isOpen ? Icons.remove : Icons.add, color: Colors.blue),
              ],
            ),

            if (isOpen) ...[
              const SizedBox(height: 12),
              Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
