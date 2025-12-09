import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onCapture;

  const CaptureButton({super.key, required this.onCapture});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCapture,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 22, 107, 199),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.camera_alt,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
