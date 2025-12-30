import 'dart:convert';
import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class RegistrasiRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(RegistrasiEntity entity) async {
    // 1️⃣ Firebase Register
    final credential = await _auth.createUserWithEmailAndPassword(
      email: entity.email,
      password: entity.password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Registrasi Firebase gagal');
    }

    // 2️⃣ Email verifikasi
    await user.sendEmailVerification();

    // 3️⃣ Update display name (opsional)
    await user.updateDisplayName(entity.name);

    // 4️⃣ Ambil Firebase ID TOKEN (JWT)
    final token = await user.getIdToken();
    if (token == null || token.isEmpty) {
      throw Exception('Gagal mengambil Firebase token');
    }

    // 5️⃣ Kirim ke Laravel (Bearer)
    final response = await http.post(
      Uri.parse('https://API_KAMU/api/register'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': entity.name,
        'gender': entity.gender,
        'age': entity.age,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Registrasi backend gagal');
    }
  }
}
