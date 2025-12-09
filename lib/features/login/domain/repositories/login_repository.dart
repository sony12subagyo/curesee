import 'package:curesee/features/login/domain/entities/login_entitiy.dart';

abstract class LoginRepository {
  Future<LoginEntity> login(String email, String password);
}
