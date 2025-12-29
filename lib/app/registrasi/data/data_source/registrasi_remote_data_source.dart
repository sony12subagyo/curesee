import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrasiRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(RegistrasiEntity entity) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: entity.email,
      password: entity.password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Gagal membuat akun');
    }

    // 🔥 KIRIM EMAIL VERIFIKASI KE GMAIL
    await user.sendEmailVerification();

    // Optional: update display name
    await user.updateDisplayName(entity.name);
  }
}
