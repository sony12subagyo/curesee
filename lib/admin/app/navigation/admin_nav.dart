import 'package:curesee/admin/features/users/presentation/pages/admin_page.dart';
import 'package:curesee/admin/features/blog/presentation/page/blog_page.dart';
import 'package:curesee/admin/features/users/presentation/widgets/admin_bottom_nav.dart';
import 'package:flutter/material.dart';


class AdminNav extends StatefulWidget {
  const AdminNav({super.key});

  @override
  State<AdminNav> createState() => _AdminNavState();
}

class _AdminNavState extends State<AdminNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BlogPage(),
    AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AdminBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
