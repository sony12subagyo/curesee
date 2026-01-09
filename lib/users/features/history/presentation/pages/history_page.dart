// // import 'package:flutter/material.dart';
// // import '../widgets/history_app_bar.dart';
// // import '../widgets/history_card.dart';

// // class HistoryPage extends StatelessWidget {
// //   const HistoryPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         // const HistoryAppBar(),

// //         Expanded(
// //           child: ListView.builder(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             itemCount: 6,
// //             itemBuilder: (context, index) {
// //               return HistoryCard(
// //                 onTap: () {
// //                   // nanti arahkan ke detail via router / cubit
// //                 },
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }


// import 'dart:io';
// import 'package:curesee/users/features/history/presentation/bloc/history_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HistoryPage extends StatelessWidget {
//   const HistoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Center(child: const Text("Riwayat Scan",style: TextStyle(color: Colors.blue),))),
//       body: BlocBuilder<HistoryBloc, HistoryState>(
//         builder: (context, state) {
//           if (state is HistoryLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HistoryLoaded) {
//             if (state.scans.isEmpty) {
//               return const Center(child: Text("Belum ada hasil scan"));
//             }

//             return ListView.builder(
//               itemCount: state.scans.length,
//               itemBuilder: (context, i) {
//                 final scan = state.scans[i];
//                 return ListTile(
//                   leading: Image.file(File(scan.imagePath), width: 56),
//                   title: Text(scan.label.toUpperCase()),
//                   subtitle: Text(
//                     "${(scan.confidence * 100).toStringAsFixed(1)}% • ${scan.createdAt}",
//                   ),
//                 );
//               },
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }