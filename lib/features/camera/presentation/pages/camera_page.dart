import 'package:curesee/features/camera/data/data_source/camera_datasource.dart';
import 'package:curesee/features/camera/domain/usecase/take_picture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../data/repositories/camera_repository_impl.dart';
import 'preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final TakePicture _takePicture;

  CameraController? _controller;
  Future<void>? _initializeCamera;

  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0; // 0 = belakang, 1 = depan

  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    _takePicture = TakePicture(
      CameraRepositoryImpl(CameraDataSourceImpl()),
    );

    _loadCameras();
  }

  Future<void> _loadCameras() async {
    _cameras = await availableCameras();
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int index) async {
    final camera = _cameras![index];

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeCamera = _controller!.initialize().then((_) async {
      await _controller!.setFlashMode(_flashMode);
    });

    if (mounted) setState(() {});
  }

  // 🔄 SWITCH CAMERA
  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    _selectedCameraIndex = _selectedCameraIndex == 0 ? 1 : 0;

    await _initCamera(_selectedCameraIndex);
  }

  // 🔦 FLASH ICON /////////////////
  IconData _flashIcon() {
    switch (_flashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      default:
        return Icons.flash_off;
    }
  }

  Future<void> _changeFlash(FlashMode mode) async {
    if (_controller == null) return;

    await _controller!.setFlashMode(mode);
    setState(() => _flashMode = mode);
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
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : FutureBuilder(
              future: _initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      // 📷 FULLSCREEN PREVIEW
                      Positioned.fill(child: CameraPreview(_controller!)),

                      // 🔦 FLASH BUTTON (TOP LEFT)
                      Positioned(
                        top: 40,
                        left: 20,
                        child: PopupMenuButton<String>(
                          color: Colors.white,
                          offset: const Offset(0, 40),
                          onSelected: (value) {
                            if (value == "auto") {
                              _changeFlash(FlashMode.auto);
                            } else if (value == "on") {
                              _changeFlash(FlashMode.always);
                            } else {
                              _changeFlash(FlashMode.off);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _flashIcon(),
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: "auto", child: Text("Auto")),
                            PopupMenuItem(value: "on", child: Text("On")),
                            PopupMenuItem(value: "off", child: Text("Off")),
                          ],
                        ),
                      ),

                      // 🔄 SWITCH CAMERA (TOP RIGHT)
                      Positioned(
                        top: 40,
                        right: 20,
                        child: GestureDetector(
                          onTap: _switchCamera,
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
                        ),
                      ),

                      // 📸 CAPTURE BUTTON
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                final image = await _takePicture();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PreviewPage(imagePath: image.path),
                                  ),
                                );

                                _initCamera(_selectedCameraIndex);

                              } catch (e) {
                                print("Capture error: $e");
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.black, width: 4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              },
            ),
    );
  }
}
