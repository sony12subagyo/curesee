import 'package:curesee/app/login/data/data_source/login_remote_datasource.dart';
import 'package:curesee/app/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final DummyLoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) {
    return dataSource.login(email, password);
  }
}
