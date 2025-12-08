import 'package:curesee/features/camera/domain/reporitories/camera_repository.dart';

import '../entities/captured_image.dart';


class TakePicture {
  final CameraRepository repository;

  TakePicture(this.repository);

  Future<CapturedImage> call() async {
    return await repository.takePicture();
  }
}
