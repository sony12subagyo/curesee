import 'package:curesee/features/profile/domain/repositories/profil_repository.dart';

class DeleteProfile {
  final ProfileRepository repository;
  DeleteProfile(this.repository);

  Future<void> call(int userid) async {
    return await repository.deleteProfile(userid);
  }
}
