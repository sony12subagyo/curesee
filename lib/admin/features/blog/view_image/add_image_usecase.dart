import 'dart:io';
import 'image_repository.dart';

class AddImageUsecase {
  final ImageRepository repository;

  AddImageUsecase(this.repository);

  Future<File?> call() async {
    return repository.pickImage();
  }
}
