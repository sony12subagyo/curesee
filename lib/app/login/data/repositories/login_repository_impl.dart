import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data_source/login_remote_datasource.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;

  LoginRepositoryImpl(this.remote);

  @override
  Future<String> login(String email, String password) async {
    return await remote.login(email, password);
  }

  @override
  Future<String> fetchRole(String token) async {
    final response = await http.get(
      Uri.parse('https://a9faa2a6661c.ngrok-free.app/api/profile'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil role (${response.statusCode}): ${response.body}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (!data.containsKey('role') || data['role'] == null) {
      throw Exception('Response tidak memiliki field role');
    }

    return data['role'] as String;
  }
}
