import 'package:firebase_auth/firebase_auth.dart';

class UserLoginRepositoryImpl {
  final FirebaseAuth _auth;

  UserLoginRepositoryImpl({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  /// return Firebase ID Token
  Future<String> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User tidak ditemukan');
    }

    final token = await user.getIdToken();
    if (token == null) {
      throw Exception('Gagal mengambil Firebase token');
    }

    return token;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
