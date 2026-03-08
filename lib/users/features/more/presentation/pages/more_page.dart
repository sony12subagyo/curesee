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
      create: (context) => MoreBloc(),
      child: const _MoreView(),
    );
  }
}

class _MoreView extends StatelessWidget {
  const _MoreView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: const [

          /// HEADER
          SliverToBoxAdapter(child: _Header()),

          SliverToBoxAdapter(child: SizedBox(height: 6)),

          /// TAB HELP
          SliverToBoxAdapter(child: PilihanTab()),

          SliverToBoxAdapter(child: SizedBox(height: 6)),

          /// LIST HELP
          HelpList(),

          SliverToBoxAdapter(child: SizedBox(height: 4)),

          /// CONTACT
          SliverToBoxAdapter(child: KontakKami()),

          SliverToBoxAdapter(child: SizedBox(height: 24)),

          /// VERSION
          SliverToBoxAdapter(child: _AppVersion()),

          /// SPACING UNTUK BOTTOM NAV
          SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Bantuan & Informasi",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "Temukan jawaban atas pertanyaan Anda di sini",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppVersion extends StatelessWidget {
  const _AppVersion();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "CureSee v1.0.0",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}