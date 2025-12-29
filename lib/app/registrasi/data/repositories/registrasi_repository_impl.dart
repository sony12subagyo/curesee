import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import '../../domain/repositories/registrasi_repository.dart';
import '../data_source/registrasi_remote_data_source.dart';

class RegistrasiRepositoryImpl implements RegistrasiRepository {
  final RegistrasiRemoteDataSource remote;

  RegistrasiRepositoryImpl(this.remote);

  @override
  Future<void> register(RegistrasiEntity entity) {
    return remote.register(entity);
  }
}
