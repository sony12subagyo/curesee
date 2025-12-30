import '../../data/repositories/user_login_repository_impl.dart';

class UserLoginUsecase {
  final UserLoginRepositoryImpl repository;

  UserLoginUsecase(this.repository);

  /// return Firebase Token
  Future<String> execute(String email, String password) {
    return repository.login(email, password);
  }
}
