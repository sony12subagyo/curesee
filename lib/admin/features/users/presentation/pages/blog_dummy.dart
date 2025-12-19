import 'package:flutter/material.dart';

class AdminBlogPage extends StatelessWidget {
  const AdminBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Halaman Blog Admin',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
