import 'package:curesee/admin/app/navigation/background_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/history_bloc.dart';
import '../bloc/history_event.dart';
import '../bloc/history_state.dart';
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
    return BackgroundWrapper(
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoryLoaded) {
            if (state.scans.isEmpty) {
              return const Center(child: Text("Belum ada riwayat"));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 90),
              itemCount: state.scans.length,
              itemBuilder: (context, i) {
                final scan = state.scans[i];
                return HistoryCard(
                  scan: scan,
                  onDelete: () {
                    context
                        .read<HistoryBloc>()
                        .add(DeleteScanEvent(scan.id));
                  },
                );
              },
            );
          }

          if (state is HistoryError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
