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
            "q": "Apa itu CureSee?",
            "a":
                "CureSee adalah aplikasi berbasis kecerdasan buatan (AI) yang membantu pengguna melakukan deteksi awal kondisi kulit melalui kamera ponsel. Aplikasi ini memberikan prediksi jenis masalah kulit beserta tingkat kepercayaannya untuk membantu pengguna memahami kondisi kulitnya sebelum berkonsultasi dengan tenaga medis.",
          },
          {
            "q": "Apakah CureSee dapat menggantikan dokter?",
            "a":
                "Tidak. CureSee hanya memberikan hasil prediksi berbasis AI dan tidak menggantikan diagnosis dokter. Untuk hasil yang akurat dan penanganan medis, pengguna tetap disarankan berkonsultasi dengan dokter atau tenaga kesehatan profesional.",
          },
          {
            "q": "Bagaimana cara kerja fitur scan kulit?",
            "a":
                "CureSee menggunakan kamera ponsel dan model AI yang telah dilatih dengan ribuan citra kulit untuk menganalisis pola visual pada kulit. Sistem akan memberikan beberapa prediksi kondisi kulit dengan tingkat kepercayaan masing-masing.",
          },
          {
            "q": "Apakah data dan gambar saya aman?",
            "a":
                "Ya. CureSee menerapkan sistem keamanan dan penyimpanan yang melindungi data pengguna. Hasil scan hanya dapat diakses oleh pemilik akun dan tidak dibagikan kepada pihak lain tanpa izin.",
          },
        ];

      case MorePusatBantuan.akun:
        return [
          {
            "q": "Bagaimana cara membuat akun CureSee?",
            "a":
                "Kamu dapat mendaftar menggunakan email dan password melalui halaman registrasi di aplikasi. Setelah mendaftar, kamu dapat langsung menggunakan fitur scan dan menyimpan riwayat hasil analisis.",
          },
          {
            "q": "Apa yang harus saya lakukan jika lupa password?",
            "a":
                "Kamu bisa memberi informasi berupa Email kamu ke tim Curesee melalui kontak WhatsApp, Setelah itu tim curesee akan membantu untuk chek password yang kamu pakai di akun kamu",
          },
          {
            "q": "Saya tidak bisa login, apa yang harus saya lakukan?",
            "a": "Pastikan email dan password yang kamu masukkan benar.",
          },
        ];
    }
  }
}
