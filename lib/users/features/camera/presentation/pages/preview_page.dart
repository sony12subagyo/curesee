import 'dart:io';
import 'package:curesee/users/features/camera/presentation/widgets/detection_result_list.dart';
import 'package:curesee/users/features/camera/presentation/widgets/photo_preview_card.dart';
import 'package:curesee/users/features/camera/presentation/widgets/preview_action_buttons.dart';
import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/users/features/history/presentation/bloc/history_bloc.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_descriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../skin_scane/presentation/skin_detection_bloc.dart';
import '../../../skin_scane/presentation/skin_detection_state.dart';

class PreviewPage extends StatelessWidget {
  final String imagePath;

  const PreviewPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.all(12),
            //     child: Container(
            //       margin: const EdgeInsets.symmetric(
            //         horizontal: 4,
            //         vertical: 6,
            //       ),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.white.withOpacity(0.05),
            //         border: Border.all(
            //           color: Colors.white.withOpacity(0.5),
            //           width: 1.5,
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black.withOpacity(0.25),
            //             blurRadius: 10,
            //             offset: const Offset(0, 5),
            //           ),
            //         ],
            //       ),
            //       clipBehavior: Clip.antiAlias,
            //       child: Padding(
            //         padding: const EdgeInsets.all(
            //           4,
            //         ), // 🔥 ini bikin foto terasa "masuk frame"
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(14),
            //           child: Image.file(
            //             File(imagePath),
            //             width: double.infinity,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(flex: 3, child: PhotoPreviewCard(imagePath: imagePath)),

            //HASIL DETEKSI
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: BlocBuilder<SkinDetectionBloc, SkinDetectionState>(
                  builder: (context, state) {
                    if (state is SkinDetectionLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text("Menganalisis kondisi kulit..."),
                        ],
                      );
                    }

                    if (state is SkinDetectionLoaded) {
                      return Column(
                        children: [
                          // ============================
                          // AREA SCROLL (HASIL + DESKRIPSI)
                          // ============================
                          // Expanded(
                          //   child: SingleChildScrollView(
                          //     physics: const BouncingScrollPhysics(),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         const Text(
                          //           "Hasil Scan",
                          //           style: TextStyle(
                          //             fontSize: 20,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         const SizedBox(height: 12),

                          //         ...state.result.top3.map(
                          //           (d) => Padding(
                          //             padding: const EdgeInsets.only(
                          //               bottom: 16,
                          //             ),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 // Nama + Persentase
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Text(
                          //                       d.label.toUpperCase(),
                          //                       style: const TextStyle(
                          //                         fontSize: 16,
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       "${(d.confidence * 100).toStringAsFixed(1)}%",
                          //                       style: const TextStyle(
                          //                         color: Colors.grey,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),

                          //                 const SizedBox(height: 6),

                          //                 // Progress bar
                          //                 LinearProgressIndicator(
                          //                   value: d.confidence,
                          //                   backgroundColor: Colors.grey[200],
                          //                   color: Colors.blueAccent,
                          //                   minHeight: 8,
                          //                   borderRadius: BorderRadius.circular(
                          //                     6,
                          //                   ),
                          //                 ),

                          //                 const SizedBox(height: 6),

                          //                 // Deskripsi
                          //                 Text(
                          //                   skinDescriptions[d.label] ??
                          //                       "Tidak ada deskripsi.",
                          //                   style: const TextStyle(
                          //                     fontSize: 13,
                          //                     color: Colors.black54,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          Expanded(
                            child: DetectionResultList(result: state.result),
                          ),

                          const SizedBox(height: 12),

                          // ============================
                          // TOMBOL (TETAP DI BAWAH)
                          // ============================
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: OutlinedButton.icon(
                          //         icon: const Icon(
                          //           Icons.camera_alt,
                          //           color: Colors.blue, // icon biru
                          //         ),
                          //         label: const Text(
                          //           "Scan Ulang",
                          //           style: TextStyle(color: Colors.blue),
                          //         ),
                          //         onPressed: () => Navigator.pop(context),
                          //         style: OutlinedButton.styleFrom(
                          //           padding: const EdgeInsets.symmetric(
                          //             vertical: 14,
                          //           ),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //           side: BorderSide(
                          //             color: Colors.blue,
                          //             width: 1.5,
                          //           ),
                          //         ),
                          //       ),
                          //     ),

                          //     const SizedBox(width: 12),

                          //     Expanded(
                          //       child: ElevatedButton.icon(
                          //         icon: const Icon(
                          //           Icons.save_alt_rounded,
                          //           color: Colors.blue,
                          //         ),
                          //         label: const Text(
                          //           "Simpan",
                          //           style: TextStyle(color: Colors.blue),
                          //         ),
                          //         onPressed: () {
                          //           final state = context
                          //               .read<SkinDetectionBloc>()
                          //               .state;
                          //           if (state is SkinDetectionLoaded) {
                          //             final top = state.result.top3.first;

                          //             // final scan = HistoryScan(
                          //             //   id: DateTime.now()
                          //             //       .millisecondsSinceEpoch
                          //             //       .toString(),
                          //             //   imagePath: imagePath,
                          //             //   label: top.label,
                          //             //   confidence: top.confidence,
                          //             //   createdAt: DateTime.now(),
                          //             // );

                          //             // context.read<HistoryBloc>().add(
                          //             //   SaveScanEvent(scan),
                          //             // );

                          //             ScaffoldMessenger.of(
                          //               context,
                          //             ).showSnackBar(
                          //               const SnackBar(
                          //                 content: Text("Hasil scan disimpan"),
                          //               ),
                          //             );
                          //           }
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           padding: const EdgeInsets.symmetric(
                          //             vertical: 14,
                          //           ),
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //           ),
                          //           side: BorderSide(
                          //             color: Colors.blue,
                          //             width: 1.5,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          PreviewActionButtons(imagePath: imagePath),

                        ],
                      );
                    }

                    if (state is SkinDetectionError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
