import 'package:curesee/users/features/more/presentation/widget/help_kategori.dart';
import 'package:curesee/users/features/more/presentation/widget/help_tab.dart';
import 'package:curesee/users/features/more/presentation/widget/kontak_kami.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/more_bloc.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoreBloc(),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: PilihanTab()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const HelpList(),
          const SliverToBoxAdapter(child: KontakKami()),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ), // jarak dari bottom nav
        ],
      ),
    );
  }
}
