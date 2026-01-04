// import 'dart:io';
// import 'package:flutter/material.dart';

// class PreviewPage extends StatelessWidget {
//   final String imagePath;

//   PreviewPage({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: SafeArea(
//         child: Column(
//           children: [

//             // Tombol Back + Judul
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       padding: EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                           )
//                         ],
//                       ),
//                       child: Icon(Icons.arrow_back, size: 22),
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                   Text(
//                     "Hasil Scan",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             SizedBox(height: 15),

//             // FOTO DI TENGAH
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.file(
//                   File(imagePath),
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             SizedBox(height: 25),

//             // BOX PENJELASAN (kosong dulu)
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding: EdgeInsets.all(18),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 12,
//                       offset: Offset(0, 3),
//                     )
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       Text(
//                         "Hasil:",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 6),

//                       Text(
//                         "Teks penjelasan hasil scan akan muncul di sini...",
//                         style: TextStyle(fontSize: 14),
//                         textAlign: TextAlign.justify,
//                       ),

//                       SizedBox(height: 20),

//                       Text(
//                         "Diagnosis:",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 6),

//                       Text(
//                         "Belum ada data",
//                         style: TextStyle(fontSize: 14),
//                       ),

//                       SizedBox(height: 20),

//                       Text(
//                         "Tindakan Awal:",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 6),

//                       Text(
//                         "Informasi tindakan awal akan ditampilkan setelah analisis.",
//                         style: TextStyle(fontSize: 14),
//                         textAlign: TextAlign.justify,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // =======================
            // FOTO
            // =======================
            Expanded(
              flex: 3,
              child: Image.file(
                File(imagePath),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            //HASIL DETEKSI
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: BlocBuilder<SkinDetectionBloc, SkinDetectionState>(
                  builder: (context, state) {
                    if (state is SkinDetectionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SkinDetectionLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Kemungkinan Penyakit:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          ...state.result.top3.map(
                            (d) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    d.label.toUpperCase(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "${(d.confidence * 100).toStringAsFixed(1)}%",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
