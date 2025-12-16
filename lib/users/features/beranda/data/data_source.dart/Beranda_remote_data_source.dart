import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';

class BerandaRemoteDataSource {
  Future<List<Beranda>> getBerandaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Beranda(
        id: '1',
        title: 'Info Kulit',
        subtitle: 'Kenali jenis kulitmu',
        imageUrl: 'https://picsum.photos/400/200?1',
        createdAt: DateTime.now(),
      ),
      Beranda(
        id: '2',
        title: 'Tips Skincare',
        subtitle: 'Perawatan harian kulit sehat',
        imageUrl: 'https://picsum.photos/400/200?2',
        createdAt: DateTime.now(),
      ),
    ];
  }
}
