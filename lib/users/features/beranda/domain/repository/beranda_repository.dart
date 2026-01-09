import '../entities/beranda.dart';

abstract class BerandaRepository {
  Future<List<Beranda>> getBeranda();
}
