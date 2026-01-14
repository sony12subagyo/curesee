import 'package:curesee/users/features/beranda/data/data_source.dart/Beranda_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
// DATA
import 'package:curesee/users/features/beranda/data/repository/beranda_repository_impl.dart';
// BLOC
import 'package:curesee/users/features/beranda/presentation/bloc/beranda_bloc.dart';
import 'package:curesee/users/features/beranda/presentation/bloc/beranda_event.dart';
import 'package:curesee/users/features/beranda/presentation/bloc/beranda_state.dart';
// UI
import 'package:curesee/users/features/beranda/presentation/widgets/card_page.dart';
import 'package:curesee/users/features/beranda/presentation/widgets/card_detail_page..dart';
import 'package:curesee/users/features/beranda/presentation/widgets/carousel/beranda_carousel.dart';
import 'package:curesee/users/features/beranda/presentation/widgets/recomended_information/recommended_information.dart';

/// =======================================================
/// ENTRY POINT – PROVIDER (WAJIB ADA)
/// =======================================================
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final dio = Dio(
          BaseOptions(
            baseUrl: 'https://67d4390a3ec1.ngrok-free.app/api',
          ),
        );
        return BerandaBloc(BerandaRepositoryImpl(BerandaRemoteDatasource(dio)))
          ..add(GetBerandaRequested());
      },
      child: const _BerandaView(),
    );
  }
}

/// =======================================================
/// VIEW – UI ONLY (AMAN)
/// =======================================================
class _BerandaView extends StatelessWidget {
  const _BerandaView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return Column(children: [Expanded(child: _buildList(context))]);
        }

        if (width < 1024) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(children: [Expanded(child: _buildList(context))]),
              ),
              const Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Select an article',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(children: [Expanded(child: _buildList(context))]),
            ),
            const Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  'Detail Content Area',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// =======================================================
  /// LIST CONTENT (BLOC CONNECTED)
  /// =======================================================
  Widget _buildList(BuildContext context) {
    return BlocBuilder<BerandaBloc, BerandaState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),

            // carousel yang pake API
            if (state is BerandaLoaded) ...[
              BerandaCarousel(blogs: state.beranda),
              const SizedBox(height: 24),
            ] else ...[
              const SizedBox(height: 160),
              const SizedBox(height: 24),
            ],

            const SizedBox(height: 24),
            //ini buat yang informasi terbaru
            if (state is BerandaLoaded) ...[
              RecommendedInformation(blogs: state.beranda, limit: 4),
              const SizedBox(height: 16),
            ],

            const SizedBox(height: 16),

            const Text(
              'Informasi Tentang Kulit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // LOADING
            if (state is BerandaLoading)
              const Center(child: CircularProgressIndicator()),

            // DATA FROM API
            if (state is BerandaLoaded)
              ...state.beranda.map((blog) {
                return Column(
                  children: [
                    CardPage(
                      image: NetworkImage(blog.imageUrl),
                      title: blog.title,
                      subtitle: blog.description,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CardDetail(
                              title: blog.title,
                              description: blog.description,
                              imageUrl: blog.imageUrl,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),

            // ERROR
            if (state is BerandaFailure)
              Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
