import 'package:firebase_auth/firebase_auth.dart';

class LoginRemoteDataSource {
  final FirebaseAuth _auth;

  LoginRemoteDataSource({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  /// Login USER via Firebase
  Future<String> loginUser(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('User Firebase tidak ditemukan');
    }

    final token = await user.getIdToken();
    if (token == null || token.isEmpty) {
      throw Exception('Firebase ID Token kosong');
    }

    return token;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
