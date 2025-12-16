import 'package:curesee/users/features/beranda/data/data_source.dart/Beranda_remote_data_source.dart';
import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';
import 'package:curesee/users/features/beranda/domain/repository/beranda_repository.dart';

class BerandaRepositoryImpl implements BerandaRepository {
  final BerandaRemoteDataSource remoteDataSource;

  BerandaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Beranda>> getBerandaList() {
    return remoteDataSource.getBerandaList();
  }
}
