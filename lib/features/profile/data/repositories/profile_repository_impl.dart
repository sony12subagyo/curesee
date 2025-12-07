import 'package:curesee/features/profile/data/data_souce/profile_remote_data_source.dart';
import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:curesee/features/profile/domain/repositories/profil_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Profile>> getAllProfile() async {
    return await remoteDataSource.getAllProfile();
  }

  @override
  Future<void> updateProfile(int userid, Profile profile) async {
    await remoteDataSource.updateProfile(userid, profile);
  }
}
