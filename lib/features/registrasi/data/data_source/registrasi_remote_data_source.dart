import '../model/registrasi_model.dart';

abstract class RegistrasiRemoteDataSource {
  Future<RegistrasiModel> registrasi({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  });
}

class DummyRegistrasiRemoteDataSource implements RegistrasiRemoteDataSource {
  @override
  Future<RegistrasiModel> registrasi({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    return RegistrasiModel(name: name, email: email, gender: gender, age: age);
  }
}
