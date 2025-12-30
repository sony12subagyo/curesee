import '../../data/repositories/admin_login_repository_impl.dart';

class AdminLoginUsecase {
  final AdminLoginRepositoryImpl repository;

  AdminLoginUsecase(this.repository);

  /// return Sanctum Token
  Future<String> execute(String email, String password) {
    return repository.login(email, password);
  }
}
