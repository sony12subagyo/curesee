import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman Profil")),
      body: Center(
        child: Container(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'lib\features\profile\presentation\pages\more\profil.jpg',
                ),
              ),
              Text("Refida Septiana Putri"),
              Text("Perempuan"),
              Text("septianaputrirefida@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }
}
