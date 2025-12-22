import 'package:firebase_auth/firebase_auth.dart';

class LoginRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      final idTokenResult = await user.getIdTokenResult();
      final token = idTokenResult.token;

      if (token == null) {
        throw Exception('Gagal mengambil token');
      }

      return token;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login Firebase gagal');
    }
  }
}
