import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';

abstract class BerandaRepository {
  Future<List<Beranda>> getBerandaList();
}
