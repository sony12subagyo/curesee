import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class FlashButton extends StatelessWidget {
  final FlashMode flashMode;
  final Function(FlashMode) onFlashChanged;

  const FlashButton({
    super.key,
    required this.flashMode,
    required this.onFlashChanged,
  });

  IconData _flashIcon() {
    switch (flashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      default:
        return Icons.flash_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      offset: const Offset(0, 40),
      onSelected: (value) {
        if (value == "auto") onFlashChanged(FlashMode.auto);
        if (value == "on") onFlashChanged(FlashMode.always);
        if (value == "off") onFlashChanged(FlashMode.off);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: Icon(_flashIcon(), color: Colors.white, size: 28),
      ),
      itemBuilder: (_) => const [
        PopupMenuItem(value: "auto", child: Text("Auto")),
        PopupMenuItem(value: "on", child: Text("On")),
        PopupMenuItem(value: "off", child: Text("Off")),
      ],
    );
  }
}
