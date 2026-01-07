import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_detection_bloc.dart';
import 'package:curesee/users/features/skin_scane/presentation/skin_detection_state.dart';
import 'package:curesee/users/features/history/domain/entities/history_scan.dart';
import 'package:curesee/users/features/history/presentation/bloc/history_bloc.dart';

class PreviewActionButtons extends StatelessWidget {
  final String imagePath;

  const PreviewActionButtons({
    super.key,
    required this.imagePath,
  });

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
            label: const Text(
              "Simpan",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              final state = context.read<SkinDetectionBloc>().state;
              if (state is SkinDetectionLoaded) {
                final top = state.result.top3.first;

                // final scan = HistoryScan(
                //   id: DateTime.now().millisecondsSinceEpoch.toString(),
                //   imagePath: imagePath,
                //   label: top.label,
                //   confidence: top.confidence,
                //   createdAt: DateTime.now(),
                // );

                //context.read<HistoryBloc>().add(SaveScanEvent(scan));

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Hasil scan disimpan")),
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
