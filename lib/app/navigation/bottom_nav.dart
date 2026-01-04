import 'package:curesee/app/navigation/camera_nav_botton.dart';
import 'package:flutter/material.dart';
import 'nav_item.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _primaryColor = Color.fromARGB(255, 0, 128, 255);

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     top: false,
  //     child: Container(
  //       color: Colors.white, // ⬅ ini kuncinya
  //       child: SizedBox(
  //         height: 90,
  //         child: Stack(
  //           alignment: Alignment.bottomCenter,
  //           children: [
  //             _buildBar(),
  //             CameraNavButton(color: _primaryColor, onTap: () => onTap(-1)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90 + MediaQuery.of(context).padding.bottom, // ikut gesture bar
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildBar(),
          CameraNavButton(color: _primaryColor, onTap: () => onTap(-1)),
        ],
      ),
    );
  }

  Widget _buildBar() {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            activeColor: _primaryColor,
            onTap: () => onTap(0),
          ),
          NavItem(
            icon: Icons.history,
            label: 'History',
            isActive: currentIndex == 1,
            activeColor: _primaryColor,
            onTap: () => onTap(1),
          ),
          const SizedBox(width: 60),
          NavItem(
            icon: Icons.more_horiz,
            label: 'More',
            isActive: currentIndex == 2,
            activeColor: _primaryColor,
            onTap: () => onTap(2),
          ),
          NavItem(
            icon: Icons.person,
            label: 'Profil',
            isActive: currentIndex == 3,
            activeColor: _primaryColor,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
