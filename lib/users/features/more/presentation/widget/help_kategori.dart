import 'package:curesee/users/features/more/presentation/widget/list_qa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/more_bloc.dart';
import '../bloc/more_state.dart';
import 'help_item_tile.dart';

class HelpList extends StatelessWidget {
  const HelpList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
      builder: (context, state) {
        final items = pilihanlisttab(state.selectedPusatBantuan);

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: HelpItemTile(title: item["q"]!, answer: item["a"]!),
            );
          }, childCount: items.length),
        );
      },
    );
  }
}
