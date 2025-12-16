import 'package:curesee/app/login/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<Map<String, dynamic>> execute(String email, String password) {
    return repository.login(email, password);
  }
}
