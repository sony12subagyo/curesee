import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../widgets/camera_view.dart';
import '../widgets/flash_button.dart';
import '../widgets/switch_camera.dart';
import '../widgets/capture_button.dart';
import 'preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  FlashMode _flashMode = FlashMode.off;
  int _selectedCameraIndex = 0;

  Future<void>? _initializeCamera;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  Future<void> _loadCameras() async {
    _cameras = await availableCameras();
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _initCamera(int index) async {
    _controller = CameraController(
      _cameras![index],
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeCamera = _controller!.initialize().then((_) {
      _controller!.setFlashMode(_flashMode);
    });

    if (mounted) setState(() {});
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    _selectedCameraIndex = _selectedCameraIndex == 0 ? 1 : 0;

    await _initCamera(_selectedCameraIndex);
  }

  Future<void> _changeFlashMode(FlashMode mode) async {
    await _controller?.setFlashMode(mode);
    setState(() => _flashMode = mode);
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    final image = await _controller!.takePicture();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewPage(imagePath: image.path),
      ),
    );

    await _initCamera(_selectedCameraIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraView(
        controller: _controller,
        initializeCamera: _initializeCamera,
        flashButton: FlashButton(
          flashMode: _flashMode,
          onFlashChanged: _changeFlashMode,
        ),
        switchCameraButton: SwitchCameraButton(
          onSwitchCamera: _switchCamera,
        ),
        captureButton: CaptureButton(onCapture: _takePicture),
      ),
    );
  }
}
