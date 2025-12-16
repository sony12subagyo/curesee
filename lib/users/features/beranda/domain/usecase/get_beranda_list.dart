import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';
import 'package:curesee/users/features/beranda/domain/repository/beranda_repository.dart';

class GetBerandaList {
  final BerandaRepository repository;

  GetBerandaList(this.repository);

  Future<List<Beranda>> call() {
    return repository.getBerandaList();
  }
}
