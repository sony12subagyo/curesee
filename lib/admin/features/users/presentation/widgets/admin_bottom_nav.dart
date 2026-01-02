import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Account'),
      ],
    );
  }
}
