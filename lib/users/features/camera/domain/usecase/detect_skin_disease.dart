import 'dart:io';
import 'package:curesee/users/features/camera/domain/reporitories/skin_detection_repository.dart';
import '../entities/skin_detection_entity.dart';

class DetectSkinDisease {
  final SkinDetectionRepository repository;

  DetectSkinDisease(this.repository);

  Future<SkinDetectionEntity> execute(File image) {
    return repository.detectSkinDisease(image);
  }
}
