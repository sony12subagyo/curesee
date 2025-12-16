import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:curesee/app/registrasi/domain/repositories/registrasi_repository.dart';

class RegistrasiUseCase {
  final RegistrasiRepository repository;

  RegistrasiUseCase(this.repository);

  Future<RegistrasiEntity> execute({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  }) {
    return repository.registrasi(
      name: name,
      email: email,
      gender: gender,
      age: age,
      password: password,
    );
  }
}
