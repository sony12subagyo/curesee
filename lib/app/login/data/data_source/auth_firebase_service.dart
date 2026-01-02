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
      throw Exception('Firebase user null');
    }

    final token = await user.getIdToken();

    if (token == null || token.isEmpty) {
      throw Exception('Firebase token kosong');
    }

    return token; // ✅ sekarang 100% String
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
