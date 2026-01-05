import 'package:curesee/users/features/profile/domain/entities/profil.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();
  Future<void> updateProfile(Profile profile);
}
