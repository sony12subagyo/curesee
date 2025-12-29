import 'package:flutter/material.dart';

class RegistrasiHeader extends StatelessWidget {
  const RegistrasiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon_curesee.png',
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 8),
            const Text(
              'CureSee',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Sign up and improve your health today',
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
