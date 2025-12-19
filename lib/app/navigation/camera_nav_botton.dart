// class CameraNavButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const CameraNavButton({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 20,
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           width: 64,
//           height: 64,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color.fromARGB(255, 0, 128, 255),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 8,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           child: const Icon(
//             Icons.camera_alt,
//             color: Colors.white,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//   }
// }
