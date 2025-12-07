// beranda/domain/repository/beranda_repository.dart
import '../entities/beranda.dart';

abstract class BerandaRepository {
  Future<List<Beranda>> fetchBerandaList();
}
