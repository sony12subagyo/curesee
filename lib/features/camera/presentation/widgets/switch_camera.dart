import 'package:flutter/material.dart';

class SwitchCameraButton extends StatelessWidget {
  final VoidCallback onSwitchCamera;

  const SwitchCameraButton({
    super.key,
    required this.onSwitchCamera,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSwitchCamera,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.cameraswitch,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
