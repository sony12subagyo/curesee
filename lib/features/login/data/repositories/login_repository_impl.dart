import 'package:curesee/features/login/domain/entities/login_entitiy.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_source/login_remote_datasource.dart';
import '../model/login_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final DummyLoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<LoginEntity> login(String email, String password) async {
    final json = await dataSource.login(email, password);
    return LoginModel.fromJson(json);
  }
}
