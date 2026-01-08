import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDio {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    if (_dio != null) return _dio!;

    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dbd21fec81a1.ngrok-free.app/api',
        validateStatus: (code) => code != null && code < 500,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    // inject token setiap request (biar token selalu fresh)
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('admin_token');

          if (token == null || token.isEmpty) {
            debugPrint('🔴 ADMIN TOKEN NOT FOUND');
          } else {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('🟢 ADMIN TOKEN DIPAKAI: ${token.substring(0, 12)}...');
          }

          return handler.next(options);
        },
        onError: (e, handler) {
          debugPrint('❌ DIO ERROR: ${e.message}');
          debugPrint('❌ URL: ${e.requestOptions.uri}');
          debugPrint('❌ STATUS: ${e.response?.statusCode}');
          debugPrint('❌ RESPONSE: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );

    _dio = dio;
    return _dio!;
  }

  // panggil ini setelah login/logout kalau kamu mau reset instance
  static void reset() {
    _dio = null;
  }
}
