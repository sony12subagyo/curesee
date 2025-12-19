import 'package:flutter/material.dart';

class CameraNavButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const CameraNavButton({
    super.key,
    required this.onTap,
    required this.color,
  });

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
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
