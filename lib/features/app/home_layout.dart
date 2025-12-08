import 'package:curesee/features/app/background_wrapper.dart';
import 'package:flutter/material.dart';
import 'navigation/app_pages.dart';
import 'navigation/bottom_nav.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: BackgroundWrapper(
        child: IndexedStack(
          index: _currentIndex,
          children: AppPages.pages,
        ),
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
