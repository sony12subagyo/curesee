import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Profil")),
      body: Card(
        child: Column(
          children: [
            CircleAvatar(radius: 30),
            Text("Refida Septiana Putri"),
            Text("Perempuan"),
            Text("septianaputrirefida@gmail.com"),
          ],
        ),
      ),
    );
  }
}
