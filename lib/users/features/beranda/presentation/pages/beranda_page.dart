import 'package:curesee/users/features/beranda/presentation/widgets/card_detail_page..dart';
import 'package:curesee/users/features/beranda/presentation/widgets/card_page.dart';
import 'package:curesee/users/features/beranda/presentation/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          // tampilan hp
          if (width < 600) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildList(context)),
              ],
            );
          }

          // tampilan tablet
          if (width < 1024) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildHeader(),
                      Expanded(child: _buildList(context)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: const Center(
                    child: Text(
                      'Select an article',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            );
          }

          //  tampilan dekstop
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildList(context)),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: const Center(
                  child: Text(
                    'Detail Content Area',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // header
  Widget _buildHeader() {
    return CustomHeader(
      title: 'Welcome to Curesee app',
      subtitle: 'How are you today?',
      // extraText: 'ALEXANDER',
      avatar: const NetworkImage('https://i.pravatar.cc/150?img=3'),
    );
  }

  // list
  Widget _buildList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        const Text(
          'Information Skin Type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),

        ...List.generate(10, (index) {
          final imageUrl = 'https://picsum.photos/seed/picsum/200/300';
          final title = 'Blog Curesee ${index + 1}';
          final subtitle = 'ini nanti isinya deskripsi tentang blog ya ';

          return Column(
            children: [
              CardPage(
                image: NetworkImage(imageUrl),
                title: title,
                subtitle: subtitle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CardDetail(
                        title: title,
                        description: subtitle,
                        imageUrl: imageUrl,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }
}
