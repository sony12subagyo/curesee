

import 'package:curesee/admin/features/users/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> deleteUser(int id);
}
