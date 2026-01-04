import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatelessWidget {
  final CameraController? controller;
  final Future<void>? initializeCamera;
  final Widget flashButton;
  final Widget switchCameraButton;
  final Widget captureButton;

  const CameraView({
    super.key,
    required this.controller,
    required this.initializeCamera,
    required this.flashButton,
    required this.switchCameraButton,
    required this.captureButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: controller == null
          ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 0, 0, 0)))
          : FutureBuilder(
              future: initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color.fromARGB(255, 0, 0, 0)),
                  );
                }

                return Column(
                  children: [
                    // 🔝 HEADER
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pop(context), // ⬅️ KEMBALI KE HOME
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 8, 122, 222).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 22,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Text(
                            "SCAN",
                            style: TextStyle(
                              color: Color.fromARGB(255, 8, 122, 222),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Text(
                      "Scan your skin here",
                      style: TextStyle(color: Color.fromARGB(255, 8, 122, 222)),
                    ),

                    const SizedBox(height: 48),

                    // 📷 SCAN FRAME (PERSEGI 1:1, CAMERA NORMAL)
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: CameraPreview(controller!),
                            ),

                            // 🔲 OVERLAY FRAME (SCAN FEEL)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),

                            // 🔦 FLASH
                            Positioned(top: 16, left: 16, child: flashButton),

                            // 🔄 SWITCH CAMERA
                            Positioned(
                              top: 16,
                              right: 16,
                              child: switchCameraButton,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // 📸 CAPTURE
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: captureButton,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
