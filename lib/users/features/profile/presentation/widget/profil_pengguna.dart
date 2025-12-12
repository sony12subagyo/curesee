import 'package:flutter/material.dart';

class ProfilPengguna extends StatelessWidget {
  const ProfilPengguna({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(radius: 12),
          SizedBox(width: 12),
          Column(children: [Text('nama'), SizedBox(height: 14), Text('email')]),
        ],
      ),
    );
  }
}
