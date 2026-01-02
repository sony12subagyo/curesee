import 'dart:io';

import 'package:curesee/admin/features/blog/domain/repository/image_repository.dart';

class AddImageUsecase {
  final ImageRepository repository;

  AddImageUsecase(this.repository);

  Future<File?> call() async {
    return await repository.pickImage();
  }
}
