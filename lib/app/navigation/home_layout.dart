import 'package:curesee/app/navigation/background_wrapper.dart';
import 'package:curesee/users/features/camera/presentation/pages/camera_page.dart';
import 'package:flutter/material.dart';
import 'app_pages.dart';
import 'bottom_nav.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    if (index == -1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CameraPage()),
      );
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: BackgroundWrapper(
        child: IndexedStack(index: _currentIndex, children: AppPages.pages),
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
