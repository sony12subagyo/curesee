import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LoginRemoteDataSource {
  final FirebaseAuth _auth;
  final String baseUrl;

  LoginRemoteDataSource({FirebaseAuth? auth, required this.baseUrl})
      : _auth = auth ?? FirebaseAuth.instance;

  /// ===============================
  /// LOGIN USER VIA FIREBASE
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

    // reload supaya emailVerified update
    await user.reload();

    // BLOCK kalau belum verifikasi email
    if (!user.emailVerified) {
      await _auth.signOut();
      throw Exception('Email belum diverifikasi. Silakan cek email.');
    }

    // ambil token
    final String? token = await user.getIdToken(true);
    if (token == null || token.isEmpty) {
      throw Exception('Firebase ID Token kosong');
    }

    // 🔥 SINKRON KE BACKEND (AUTO CREATE / UPDATE USER)
    await _syncUserToBackend(token);

    return token;
  }

  /// ===============================
  /// SYNC FIREBASE → LARAVEL
  /// ===============================
  Future<void> _syncUserToBackend(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal sinkronisasi user ke database');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}