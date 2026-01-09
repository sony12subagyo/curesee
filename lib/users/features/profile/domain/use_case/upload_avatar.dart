import 'dart:io';

import 'package:curesee/users/features/profile/domain/repositories/profil_repository.dart';

class UploadAvatar {
  final ProfileRepository repository;
  UploadAvatar(this.repository);

  Future<String> execute(File file) {
    return repository.uploadAvatar(file);
  }
}
