import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';

abstract class RegistrasiRepository {
  Future<void> register(RegistrasiEntity entity);
}
