import 'package:curesee/app/login/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<String> loginAndGetRole(String email, String password) async {
    final token = await repository.login(email, password);
    return repository.fetchRole(token);
  }
}
