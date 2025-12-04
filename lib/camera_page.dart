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
    final backCamera = cameras.first; // kamera belakang

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
      appBar: AppBar(
        title: Text("Kamera Scan"),
      ),
      body: _controller == null
          ? Center(child: Text("Loading kamera..."))
          : FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller!);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),

      // Tombol ambil foto
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;  
            final image = await _controller!.takePicture();

            // pindah ke halaman preview foto
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewPage(imagePath: image.path),
              ),
            );
          } catch (e) {
            print("Error mengambil foto: $e");
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
