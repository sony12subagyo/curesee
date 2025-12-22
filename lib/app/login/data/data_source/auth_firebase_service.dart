import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService {
  final FirebaseAuth _auth;

  AuthFirebaseService({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User tidak ditemukan');
    }

    final tokenResult = await user.getIdTokenResult();
    final token = tokenResult.token;

    if (token == null) {
      throw Exception('Gagal mengambil token');
    }

    return token;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
