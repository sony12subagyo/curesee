import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:curesee/features/profile/domain/repositories/profil_repository.dart';

class GetAllProfile {
  final ProfileRepository repository;
  GetAllProfile(this.repository);

  Future<List<Profile>> call() async {
    return await repository.getAllProfile();
  }
}
