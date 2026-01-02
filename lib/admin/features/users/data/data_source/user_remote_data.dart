import 'dart:convert';
import 'package:curesee/admin/features/users/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> deleteUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String token;

  UserRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.token,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('BODY: ${response.body}');
    debugPrint('TOKEN DIPAKAI: $token');

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);

    if (decoded is List) {
      return decoded.map((e) => UserModel.fromJson(e)).toList();
    }

    if (decoded is Map && decoded['data'] is List) {
      return (decoded['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    }

    throw Exception('Format response tidak dikenali');
  }

  @override
  Future<void> deleteUser(int id) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus user');
    }
  }
}
