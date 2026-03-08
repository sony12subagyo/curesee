import 'dart:convert';

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
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception("User Firebase tidak ditemukan");
  }

  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "firebase_uid": user.uid,
      "firebase_email": user.email,
      "firebase_verified": user.emailVerified,
      "name": user.displayName ?? "User",
    }),
  );

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('Gagal sinkronisasi user ke database');
  }
}

  Future<void> logout() async {
    await _auth.signOut();
  }
}