import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import 'package:curesee/app/config/app_config.dart';

class UserRemoteDatasource {
  late final Dio dio;
  UserRemoteDatasource() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('admin_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<User>> getUsers() async {
    final response = await dio.get('/users'); // ✅ String BOLEH
    final body = response.data;
    List listData;

    if (body is List) {
      listData = body;
    } else if (body['data'] is List) {
      listData = body['data'];
    } else if (body['users'] is List) {
      listData = body['users'];
    } else if (body['data']?['users'] is List) {
      listData = body['data']['users'];
    } else {
      throw Exception('Format response tidak dikenali');
    }

    return listData.map((e) {
      return User(
        id: e['id'],
        name: e['name'] ?? '',
        email: e['email'] ?? '',
        imageUrl: e['image'],
      );
    }).toList();
  }

  Future<void> deleteUser(int id) async {
    await dio.delete('/users/$id');
  }
}
