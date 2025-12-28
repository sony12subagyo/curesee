import 'dart:io';
import '../entities/skin_detection_entity.dart';

abstract class SkinDetectionRepository {
  Future<SkinDetectionEntity> detectSkinDisease(File image);
}
