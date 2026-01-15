import 'package:curesee/users/features/history/data/data_source/history_remote_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_detection_bloc.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_detection_state.dart';


class PreviewActionButtons extends StatelessWidget {
  final String imagePath;

  PreviewActionButtons({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // =================
        // Scan Ulang
        // =================
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.camera_alt, color: Colors.blue),
            label: const Text(
              "Scan Ulang",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // =================
        // Simpan
        // =================
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.save_alt_rounded, color: Colors.blue),
            label: const Text("Simpan", style: TextStyle(color: Colors.blue)),
            onPressed: () async {
              final detectionState = context.read<SkinDetectionBloc>().state;

              if (detectionState is SkinDetectionLoaded) {
                final topResult = detectionState.result.top3.first;

                final user = FirebaseAuth.instance.currentUser;
                if (user == null) return;

                final api = context.read<HistoryRemoteApi>();

                await api.saveScan(
                  imagePath: imagePath,
                  label: topResult.label,
                  confidence: topResult.confidence,
                  firebaseUid: user.uid, // ✅ penting
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Scan berhasil disimpan")),
                );
              }
            },

            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
