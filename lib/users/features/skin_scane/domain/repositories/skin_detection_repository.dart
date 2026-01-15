import 'dart:io';
import '../entities/skin_detection_entity.dart';

abstract class SkinDetectionRepository {
  Future<SkinDetectionEntity> detectSkinDisease(File image);
}

//memastikan fitur AI CureSee bisa dipakai tanpa tergantung pada teknologi di baliknya (TFLite atau lainnya).