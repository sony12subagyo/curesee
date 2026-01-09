import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/beranda.dart';

class BerandaRemoteDatasource {
  final Dio dio;
  BerandaRemoteDatasource(this.dio);

  Future<List<Beranda>> getBeranda() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('LOGIN_REQUIRED');
    }

    final token = await user.getIdToken(true);

    final response = await dio.get(
      '/blog',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final data = response.data as List;

    return data.map((e) {
      return Beranda(
        id: e['id'],
        title: e['title'],
        description: e['content'] ?? '',
        imageUrl: e['image'] ?? '',
      );
    }).toList();
  }
}
