import 'package:curesee/features/registrasi/domain/entities/registrasi_entitity.dart';

abstract class RegistrasiRepository {
  Future<RegistrasiEntity> registrasi({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  });
}
