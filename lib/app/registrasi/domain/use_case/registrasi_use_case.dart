import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import '../repositories/registrasi_repository.dart';

class RegistrasiUseCase {
  final RegistrasiRepository repository;

  RegistrasiUseCase(this.repository);

  Future<void> execute(RegistrasiEntity entity) {
    return repository.register(entity);
  }
}
