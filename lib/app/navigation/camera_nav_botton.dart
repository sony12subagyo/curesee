import 'package:flutter/material.dart';

class CameraNavButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const CameraNavButton({super.key, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(66, 0, 0, 0),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(120, 158, 207, 255), // biru muda
              width: 5,
            ),
          ),
          child: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
