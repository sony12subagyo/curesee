// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:camera/camera.dart';
// import '../bloc/camera_cubit.dart';

// class FlashButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<CameraCubit>();
//     final state = context.watch<CameraCubit>().state;

//     IconData getFlashIcon() {
//       switch (state.flashMode) {
//         case FlashMode.auto:
//           return Icons.flash_auto;
//         case FlashMode.always:
//           return Icons.flash_on;
//         default:
//           return Icons.flash_off;
//       }
//     }

//     return PopupMenuButton<String>(
//       color: Colors.white,
//       offset: Offset(0, 40),
//       onSelected: (value) {
//         if (state.cameraIndex == 1) return;
//         if (value == "auto") cubit.changeFlash(FlashMode.auto);
//         if (value == "on") cubit.changeFlash(FlashMode.always);
//         if (value == "off") cubit.changeFlash(FlashMode.off);
//       },
//       child: Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.25),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(getFlashIcon(), color: Colors.white, size: 28),
//       ),
//       itemBuilder: (_) => [
//         PopupMenuItem(value: "auto", child: Text("Auto")),
//         PopupMenuItem(value: "on", child: Text("On")),
//         PopupMenuItem(value: "off", child: Text("Off")),
//       ],
//     );
//   }
// }
