import '../data_source/login_remote_datasource.dart';

class UserLoginRepositoryImpl {
  final LoginRemoteDataSource remote;

  UserLoginRepositoryImpl(this.remote);

  Future<String> login(String email, String password) {
    return remote.loginUser(email, password);
  }

  Future<void> logout() => remote.logout();
}
