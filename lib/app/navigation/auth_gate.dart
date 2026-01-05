// import 'package:curesee/users/features/beranda/presentation/pages/beranda_page.dart';
import 'package:curesee/app/navigation/home_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _canEnter() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) return false;

    await user.reload();
    final freshUser = auth.currentUser;

    if (freshUser == null) return false;

    if (!freshUser.emailVerified) {
      await auth.signOut();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _canEnter(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return const HomeLayout(); // ganti sesuai
        }

        return const LoginPage();
      },
    );
  }
}
