import 'package:curesee/app/registrasi/domain/entities/registrasi_entitity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrasiRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String baseUrl = 'https://a4bcc05d1d36.ngrok-free.app/api/register';

  Future<void> register(RegistrasiEntity entity) async {
    try {
      // 1Register Firebase
      final credential = await _auth.createUserWithEmailAndPassword(
        email: entity.email,
        password: entity.password,
      );

      final user = credential.user;
      if (user == null) {
        throw Exception('Registrasi Firebase gagal');
      }

      // 2Update display name
      await user.updateDisplayName(entity.name);
      await user.reload();

      // Kirim email verifikasi
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await FirebaseAuth.instance.signOut();

      // simpan data sementara
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('reg_name', entity.name);
      await prefs.setString('reg_gender', entity.gender);
      await prefs.setInt('reg_age', entity.age);

      // logout wajib verifikasi dulu
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registrasi Firebase error');
    }
  }
}
