import 'dart:io';

abstract class SkinDetectionEvent {}

class DetectSkinFromImage extends SkinDetectionEvent {
  final File image;

  DetectSkinFromImage(this.image);
}
