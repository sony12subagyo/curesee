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
        SizedBox(height: 6),
        Text(
          'Sign up and improve your health today',
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
