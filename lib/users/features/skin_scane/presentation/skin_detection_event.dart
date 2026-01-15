import 'dart:io';

abstract class SkinDetectionEvent {}

class DetectSkinFromImage extends SkinDetectionEvent {
  final File image;

  DetectSkinFromImage(this.image);
}

//pemicu awal agar AI mulai menganalisis gambar kulit.