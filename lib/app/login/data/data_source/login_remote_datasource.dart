import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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

    // 🔥 SYNC KE BACKEND (opsional tapi dianjurkan)
    if (baseUrl.isNotEmpty) {
      await _syncUserToBackend(token);
    }

    return token;
  }

  /// ===============================
  /// Sync user Firebase → Laravel
  /// ===============================
  Future<void> _syncUserToBackend(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Gagal sinkronisasi user ke backend');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
