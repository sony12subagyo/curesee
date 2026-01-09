import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginRemoteDataSource {
  final FirebaseAuth _auth;

  /// 🔥 BASE URL BACKEND (di-inject dari luar kalau mau)
  final String baseUrl;
  LoginRemoteDataSource({FirebaseAuth? auth, this.baseUrl = ''})
    : _auth = auth ?? FirebaseAuth.instance;

  /// ===============================
  /// Login USER via Firebase
  /// ===============================
  Future<String> loginUser(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User Firebase tidak ditemukan');
    }

    // 🔥 WAJIB reload biar emailVerified update
    await user.reload();

    // 🔥 BLOCK LOGIN kalau belum verifikasi email
    if (!user.emailVerified) {
      await FirebaseAuth.instance.signOut();
      throw Exception('Email belum diverifikasi. Silakan cek email.');
    }

    final String? token = await user.getIdToken(true);
    if (token == null || token.isEmpty) {
      throw Exception('Firebase ID Token kosong');
    }

    // 🔥 AMBIL DATA DARI LOCAL (HASIL REGISTRASI)
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('reg_name');
    final gender = prefs.getString('reg_gender');
    final age = prefs.getInt('reg_age');

    // 🔥 HANYA SYNC JIKA DATA ADA
    if (name != null && gender != null && age != null) {
      await _syncUserToBackend(
        token: token,
        name: name,
        gender: gender,
        age: age,
      );

      // 🔥 HAPUS SETELAH BERHASIL
      await prefs.remove('reg_name');
      await prefs.remove('reg_gender');
      await prefs.remove('reg_age');
    }

    return token;
  }

  /// ===============================
  /// Sync user Firebase → Laravel
  /// ===============================
  Future<void> _syncUserToBackend({
    required String token,
    required String name,
    required String gender,
    required int age,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'gender': gender, 'age': age}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menyimpan user ke database');
    }
  }

  /// ===============================
  /// LOGOUT (INI YANG KURANG ❗)
  /// ===============================
  Future<void> logout() async {
    await _auth.signOut();
  }
}
