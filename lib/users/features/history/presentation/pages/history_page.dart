import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/history_bloc.dart';
import '../widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(LoadHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Riwayat Scan",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),

      body: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryDeletedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Berhasil dihapus")),
            );
          }

          if (state is HistoryErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },

        builder: (context, state) {
          if (state is HistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryLoadedState) {
            if (state.scans.isEmpty) {
              return const Center(child: Text("Belum ada riwayat scan"));
            }

            return ListView.builder(
              itemCount: state.scans.length,
              itemBuilder: (context, i) {
                final scan = state.scans[i];

                return HistoryCard(
                  imagePath: scan.imagePath,
                  label: scan.predictions.first.label,
                  confidence: scan.predictions.first.confidence,
                  createdAt: scan.createdAt,
                  onTap: () {
                    context.read<HistoryBloc>().add(
                      LoadDetailScanEvent(scan.id),
                    );
                  },
                  onDelete: () {
                    context.read<HistoryBloc>().add(
                      DeleteScanEvent(scan.id),
                    );
                  },
                );
              },
            );
          }

          if (state is HistoryDetailLoadedState) {
            return Center(
              child: Text(
                "Detail: ${state.detail.predictions.first.label}",
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}