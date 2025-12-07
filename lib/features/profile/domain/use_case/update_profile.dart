import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:curesee/features/profile/domain/repositories/profil_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;
  UpdateProfile(this.repository);

  Future<void> call(int userid, Profile profile) async {
    return await repository.updateProfile(userid, profile);
  }
}
