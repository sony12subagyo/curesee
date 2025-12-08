import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'preview_page.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0; // 0 = belakang, 1 = depan

  Future<void>? _initializeControllerFuture;

  FlashMode _currentFlashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  Future<void> _loadCameras() async {
    _cameras = await availableCameras();
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    final camera = _cameras![cameraIndex];

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();

    // jika kamera depan → flash otomatis OFF karena tidak support
    if (cameraIndex == 1) {
      _currentFlashMode = FlashMode.off;
      await _controller!.setFlashMode(FlashMode.off);
    } else {
      await _controller!.setFlashMode(_currentFlashMode);
    }

    if (mounted) setState(() {});
  }

  void _setFlash(FlashMode mode) async {
    if (_controller == null) return;

    try {
      await _controller!.setFlashMode(mode);
      setState(() {
        _currentFlashMode = mode;
      });
    } catch (e) {
      print("Flash error: $e");
    }
  }

  // ICON FLASH
  IconData getFlashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
      default:
        return Icons.flash_off;
    }
  }

  // 🔄 SWITCH CAMERA
  void _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    setState(() {
      _selectedCameraIndex = _selectedCameraIndex == 0 ? 1 : 0;
    });

    await _initCamera(_selectedCameraIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: _controller == null
          ? Center(child: Text("Loading kamera...", style: TextStyle(color: Colors.white)))
          : FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Positioned.fill(child: CameraPreview(_controller!)),

                      // 🔦 FLASH (POJOK KIRI ATAS)
                      Positioned(
                        top: 40,
                        left: 20,
                        child: PopupMenuButton<String>(
                          color: Colors.white,
                          offset: Offset(0, 40),
                          onSelected: (value) {
                            if (_selectedCameraIndex == 1) return; // kamera depan disable
                            if (value == "auto") _setFlash(FlashMode.auto);
                            if (value == "on") _setFlash(FlashMode.always);
                            if (value == "off") _setFlash(FlashMode.off);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              getFlashIcon(),
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          itemBuilder: (_) => [
                            PopupMenuItem(value: "auto", child: Text("Auto")),
                            PopupMenuItem(value: "on", child: Text("On")),
                            PopupMenuItem(value: "off", child: Text("Off")),
                          ],
                        ),
                      ),

                      // 🔄 SWITCH CAMERA (POJOK KANAN ATAS)
                      Positioned(
                        top: 40,
                        right: 20,
                        child: GestureDetector(
                          onTap: _switchCamera,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.cameraswitch,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                      // 📸 TOMBOL AMBIL FOTO
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
                                    builder: (context) => PreviewPage(imagePath: image.path),
                                  ),
                                );
                              } catch (e) {
                                print("Error: $e");
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
