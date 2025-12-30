import 'package:curesee/admin/features/users/data/data_source/user_remote_data.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<List<UserEntity>> getUsers() {
    return remote.getUsers();
  }

  @override
  Future<void> deleteUser(int id) {
    return remote.deleteUser(id);
  }
}
