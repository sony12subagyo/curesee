import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'preview_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.first;

    _controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // agar fullscreen rapi

      body: _controller == null
          ? Center(child: Text("Loading kamera...", style: TextStyle(color: Colors.white)))
          : FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CameraPreview(_controller!), // FULLSCREEN
                      ),

                      // Tombol kamera di bawah
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt, color: Colors.black),
                            onPressed: () async {
                              try {
                                await _initializeControllerFuture;
                                final image = await _controller!.takePicture();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PreviewPage(imagePath: image.path),
                                  ),
                                );
                              } catch (e) {
                                print("Error mengambil foto: $e");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator(color: Colors.white));
              },
            ),
    );
  }
}
