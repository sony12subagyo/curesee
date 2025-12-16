import 'package:curesee/features/registrasi/data/data_source/registrasi_remote_data_source.dart';
import 'package:curesee/features/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:curesee/features/registrasi/domain/repositories/registrasi_repository.dart';

class RegistrasiRepositoryImpl implements RegistrasiRepository {
  final RegistrasiRemoteDataSource remote;

  RegistrasiRepositoryImpl(this.remote);

  @override
  Future<RegistrasiEntity> registrasi({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  }) {
    return remote.registrasi(
      name: name,
      email: email,
      gender: gender,
      age: age,
      password: password,
    );
  }
}
