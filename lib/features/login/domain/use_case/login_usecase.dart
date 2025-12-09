import 'package:curesee/features/login/domain/entities/login_entitiy.dart';
import 'package:curesee/features/login/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<LoginEntity> execute(String email, String password) {
    return repository.login(email, password);
  }
}
