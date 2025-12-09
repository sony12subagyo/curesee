import 'package:curesee/features/camera/data/data_source/camera_datasource.dart';
import 'package:curesee/features/camera/domain/reporitories/camera_repository.dart';

import '../../domain/entities/captured_image.dart';


class CameraRepositoryImpl implements CameraRepository {
  final CameraDataSource dataSource;

  CameraRepositoryImpl(this.dataSource);

  @override
  Future<CapturedImage> takePicture() {
    return dataSource.takePicture();
  }
}
