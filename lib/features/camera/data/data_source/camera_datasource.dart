import 'package:camera/camera.dart';
import '../../domain/entities/captured_image.dart';

abstract class CameraDataSource {
  Future<CapturedImage> takePicture();
}

class CameraDataSourceImpl implements CameraDataSource {
  CameraController? controller;

  @override
  Future<CapturedImage> takePicture() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller!.initialize();

    final file = await controller!.takePicture();
    return CapturedImage(file.path);
  }
}
