import 'package:flutter/material.dart';

class RegistrasiHeader extends StatelessWidget {
  const RegistrasiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'CureSee',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          'Create account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        Text(
          'Sign up and improve your health today',
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
