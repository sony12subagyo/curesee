import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrasiRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

      // 2️⃣ Simpan nama ke Firebase profile (optional)
      await user.updateDisplayName(entity.name);
      await user.reload();

      // 3️⃣ Kirim email verifikasi
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      // 4️⃣ SIMPAN DATA SEMENTARA (UNTUK SYNC SAAT LOGIN)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('reg_name', entity.name);
      await prefs.setString('reg_gender', entity.gender);
      await prefs.setInt('reg_age', entity.age);

      // 5️⃣ LOGOUT PAKSA → WAJIB VERIFIKASI DULU
      await _auth.signOut();

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registrasi Firebase error');
    }
  }
}