import 'package:curesee/admin/features/blog/presentation/pages/blog_page.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_page.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const AdminLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BlogPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminPage()),
      );
    }
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _logout(context);
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hallo Admin CureSee",
          style: TextStyle(
            color: Colors.white,
            fontSize:20,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 128, 255),
        iconTheme: const IconThemeData(color:Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),

      body: child,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color.fromARGB(255, 0, 128, 255),
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Account'),
        ],
      ),
    );
  }
}
