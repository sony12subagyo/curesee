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
    return controller == null
        ? const Center(child: CircularProgressIndicator(color: Colors.white))
        : FutureBuilder(
            future: initializeCamera,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              return Stack(
                children: [
                  Positioned.fill(
                    child: CameraPreview(controller!),
                  ),

                  Positioned(top: 40, left: 20, child: flashButton),
                  Positioned(top: 40, right: 20, child: switchCameraButton),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: captureButton,
                    ),
                  ),
                ],
              );
            },
          );
  }
}
