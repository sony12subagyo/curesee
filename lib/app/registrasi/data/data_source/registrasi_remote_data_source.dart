import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrasiRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String baseUrl = 'https://6338b68a9255.ngrok-free.app/api/register';

  Future<void> register(RegistrasiEntity entity) async {
    try {
      // 1️⃣ Register Firebase
      final credential = await _auth.createUserWithEmailAndPassword(
        email: entity.email,
        password: entity.password,
      );

      final user = credential.user;
      if (user == null) {
        throw Exception('Registrasi Firebase gagal');
      }

      // 2️⃣ Update display name
      await user.updateDisplayName(entity.name);
      await user.reload();

      // 3️⃣ Kirim email verifikasi
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        await FirebaseAuth.instance.signOut();
      }

      // ❌ STOP DI SINI
      // JANGAN hit backend di tahap registrasi

      return;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registrasi Firebase error');
    }
  }
}
