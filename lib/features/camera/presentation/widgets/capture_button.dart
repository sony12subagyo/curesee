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
          color: const Color.fromARGB(255, 0, 128, 255),
          shape: BoxShape.circle,
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 4),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.camera_alt,
            size: 35,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
