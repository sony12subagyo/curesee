import 'package:curesee/features/profile/domain/entities/profil.dart';

abstract class ProfileRepository {
  Future<List<Profile>> getAllProfile();
  Future<void> updateProfile(int userid, Profile profile);
}
