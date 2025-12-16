
import 'package:curesee/admin/features/blog/presentation/widget/card_page_admin.dart';
import 'package:curesee/users/features/beranda/presentation/pages/detail_information_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ===== BACKGROUND GRADIENT BIRU - PUTIH =====
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1EA3FF), // biru
              Color(0xFF7BC9FF), // biru muda
              Color(0xFFEAF7FF), // putih kebiruan
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 8),

                    const Text(
                      'Information Skin Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white, // biar kontras sama bg
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...List.generate(
                      10,
                      (index) {
                        final imageUrl =
                            'https://picsum.photos/id/${1015 + index}/800/400';
                        final title = 'Kriteria Kulit #${index + 1}';
                        final subtitle =
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit... ke-${index + 1}.';

                        return Column(
                          children: [
                            CardPageAdmin(
                              image: NetworkImage(imageUrl),
                              title: title,
                              subtitle: subtitle,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailInformationPage(
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
