import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/login_repository.dart';

class AdminLoginRepositoryImpl implements LoginRepository {
  final http.Client client;
  final String baseUrl;

  AdminLoginRepositoryImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/admin/login'),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Login admin gagal (${response.statusCode}): ${response.body}',
      );
    }

    final data = jsonDecode(response.body);
    if (!data.containsKey('token')) {
      throw Exception('Response admin tidak memiliki token');
    }

    return data['token'];
  }

  @override
  Future<String> fetchRole(String token) async {
    // admin fix
    return 'admin';
  }
}
