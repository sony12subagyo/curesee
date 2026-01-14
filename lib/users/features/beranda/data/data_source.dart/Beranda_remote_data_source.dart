import 'package:curesee/users/features/beranda/domain/entities/beranda.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BerandaRemoteDatasource {
  final Dio dio;

  BerandaRemoteDatasource(this.dio);

  Future<List<Beranda>> getBeranda() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('USER_NOT_LOGGED_IN');
    }

    final firebaseToken = await user.getIdToken();

    final response = await dio.get(
      '/blog',
      options: Options(
        headers: {
          'Authorization': 'Bearer $firebaseToken',
          'Accept': 'application/json',
        },
      ),
    );

    final List data = response.data as List;

    return data.map((e) {
      return Beranda(
        id: e['id'],
        title: e['title'] ?? '',
        description: e['content'] ?? '',
        imageUrl: e['image'] != null
            ? 'https://67d4390a3ec1.ngrok-free.app/storage/${e['image']}'
            : '',
      );
    }).toList();
  }
}