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
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : FutureBuilder(
              future: initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.arrow_back, color: Colors.white),
                          Text(
                            "SCAN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 24),
                        ],
                      ),
                    ),

                    const Text(
                      "Scan your skin here",
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 48),

                    // 📷 SCAN FRAME (LEBIH BESAR & NORMAL RATIO)
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: AspectRatio(
                                aspectRatio:
                                    controller!.value.aspectRatio,
                                child: CameraPreview(controller!),
                              ),
                            ),
                          ),

                          // 🔦 FLASH
                          Positioned(
                            top: 10,
                            left: 10,
                            child: flashButton,
                          ),

                          // 🔄 SWITCH CAMERA
                          Positioned(
                            top: 10,
                            right: 10,
                            child: switchCameraButton,
                          ),
                        ],
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
