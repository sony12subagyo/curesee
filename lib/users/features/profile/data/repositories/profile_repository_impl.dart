import 'package:curesee/users/features/profile/data/data_souce/profile_remote_data_source.dart';
import 'package:curesee/users/features/profile/domain/entities/profil.dart';
import 'package:curesee/users/features/profile/domain/repositories/profil_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    await remoteDataSource.updateProfile(profile);
  }
}
