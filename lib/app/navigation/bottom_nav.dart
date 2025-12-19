// import 'package:flutter/material.dart';

// class BottomNav extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
// Widget build(BuildContext context) {
//   return SafeArea(
//     top: false,
//     child: SizedBox(
//       height: 90,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: 65,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(24),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, -2),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _NavItem(
//                   icon: Icons.home,
//                   label: 'Home',
//                   isActive: currentIndex == 0,
//                   onTap: () => onTap(0),
//                 ),
//                 _NavItem(
//                   icon: Icons.history,
//                   label: 'History',
//                   isActive: currentIndex == 1,
//                   onTap: () => onTap(1),
//                 ),
//                 const SizedBox(width: 60),
//                 _NavItem(
//                   icon: Icons.more_horiz,
//                   label: 'More',
//                   isActive: currentIndex == 2,
//                   onTap: () => onTap(2),
//                 ),
//                 _NavItem(
//                   icon: Icons.person,
//                   label: 'Profil',
//                   isActive: currentIndex == 3,
//                   onTap: () => onTap(3),
//                 ),
//               ],
//             ),
//           ),

//           Positioned(
//             bottom: 20,
//             child: GestureDetector(
//               onTap: () => onTap(-1),
//               child: Container(
//                 width: 64,
//                 height: 64,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color.fromARGB(255, 0, 128, 255),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }

// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;
//   final VoidCallback onTap;

//   const _NavItem({
//     required this.icon,
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = isActive
//         ? const Color.fromARGB(255, 0, 128, 255)
//         : Colors.grey;

//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.translucent,
//       child: SizedBox(
//         width: 60,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: color),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(fontSize: 12, color: color),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'nav_item.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _primaryColor = Color.fromARGB(255, 0, 128, 255);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 90,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildBar(),
            _buildCameraButton(),
          ],
        ),
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

  Widget _buildCameraButton() {
    return Positioned(
      bottom: 20,
      child: GestureDetector(
        onTap: () => onTap(-1), // khusus kamera
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

