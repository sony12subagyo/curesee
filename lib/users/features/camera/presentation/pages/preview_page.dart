import 'dart:io';
import 'package:curesee/users/features/camera/presentation/widgets/detection_result_list.dart';
import 'package:curesee/users/features/camera/presentation/widgets/photo_preview_card.dart';
import 'package:curesee/users/features/camera/presentation/widgets/preview_action_buttons.dart';
import 'package:firebase_core/firebase_core.dart';
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
            //PREVIEW FOTO
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
                          Expanded(
                            child: DetectionResultList(result: state.result),
                          ),

                          const SizedBox(height: 12),

                          PreviewActionButtons(
                            imagePath: imagePath,
                          ), // Tambahkan id_user di sini
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
