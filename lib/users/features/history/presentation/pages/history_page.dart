import 'package:flutter/material.dart';
import '../widgets/history_app_bar.dart';
import '../widgets/history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HistoryAppBar(),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return HistoryCard(
                onTap: () {
                  // nanti arahkan ke detail via router / cubit
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
