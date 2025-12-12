import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon_curesee.png',
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 5),
            const Text(
              "CureSee",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 12),

        const Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        const Text(
          'Ready to scan your skin now? Log in!',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
