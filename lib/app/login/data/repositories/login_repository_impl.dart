import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data_source/login_remote_datasource.dart';
import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remote;

  LoginRepositoryImpl(this.remote);

  @override
  Future<String> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<String> fetchRole(String token) async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/profile'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil role');
    }

    final data = jsonDecode(response.body);
    return data['role'];
  }
}
