import 'package:curesee/users/features/beranda/data/data_source.dart/Beranda_remote_data_source.dart';

import '../../domain/entities/beranda.dart';
import '../../domain/repository/beranda_repository.dart';

class BerandaRepositoryImpl implements BerandaRepository {
  final BerandaRemoteDatasource remote;

  BerandaRepositoryImpl(this.remote);

  @override
  Future<List<Beranda>> getBeranda() {
    return remote.getBeranda();
  }
}
