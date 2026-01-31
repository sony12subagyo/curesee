import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker picker;

  ImageRepositoryImpl(this.picker);

  @override
  Future<File?> pickImage() async {
    final XFile? picked =
        await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return null;
    return File(picked.path);
  }
}
