import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/more_bloc.dart';
import '../bloc/more_state.dart';
import '../bloc/more_event.dart';
import 'help_item_tile.dart';

class HelpList extends StatelessWidget {
  const HelpList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreBloc, MoreState>(
      builder: (context, state) {
        final items = _getHelpItems(state.selectedPusatBantuan);

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

  List<Map<String, String>> _getHelpItems(MorePusatBantuan kategori) {
    switch (kategori) {
      case MorePusatBantuan.informasiumum:
        return [
          {
            "q": "Apa itu Diri Care?",
            "a":
                "Diri Care adalah klinik kesehatan kulit dan rambut terdepan di Indonesia. Di Diri Care, kamu bisa mendapatkan solusi kulit lebih cerah, sehat, rambut lebih lebat, serta layanan konsultasi dokter secara online maupun offline.",
          },
          {
            "q": "Apakah saya bisa mendapatkan produk tanpa konsultasi?",
            "a":
                "Beberapa produk dapat dibeli tanpa konsultasi, namun untuk hasil terbaik kami menyarankan melakukan konsultasi terlebih dahulu.",
          },
        ];

      case MorePusatBantuan.akun:
        return [
          {
            "q": "Bagaimana cara login?",
            "a":
                "Kamu bisa login menggunakan email dan password yang telah terdaftar pada aplikasi Diri Care.",
          },
          {
            "q": "Saya lupa password",
            "a":
                "Gunakan fitur lupa password di halaman login untuk mengatur ulang password kamu.",
          },
        ];
    }
  }
}
