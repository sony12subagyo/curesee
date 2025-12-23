import 'package:firebase_auth/firebase_auth.dart';

class LoginRemoteDataSource {
  final FirebaseAuth _auth;

  LoginRemoteDataSource({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  /// Login ke Firebase dan return ID TOKEN (JWT)
  Future<String> login(String email, String password) async {
    final UserCredential credential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = credential.user;
    if (user == null) {
      throw Exception('User Firebase tidak ditemukan');
    }

    final String? token = await user.getIdToken();
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
