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
  final List<String> _titles = ['Home', 'History', 'More', 'Profile'];

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
      extendBody: true,
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 128, 255),
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.shopping_cart_outlined),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),

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
