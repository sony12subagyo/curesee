import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 20),
        Icon(Icons.favorite, size: 48, color: Colors.black),
        SizedBox(height: 8),
        Text(
          'CureSee',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          'Ready to scan your skin now? Log in!',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
