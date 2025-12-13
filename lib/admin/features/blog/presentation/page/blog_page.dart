
import 'package:curesee/admin/features/blog/presentation/page/detail_information_page.dart';
import 'package:curesee/admin/features/blog/presentation/widget/card_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea( // karena tidak pakai Scaffold
      child: Column(
        children: [
         

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 8),

                const Text(
                  'Information Skin Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                // Generate 10 CardPage
                ...List.generate(
                  10,
                  (index) {
                    final imageUrl =
                        'https://picsum.photos/id/${1015 + index}/800/400';
                    final title = 'Kriteria Kulit #${index + 1}';
                    final subtitle =
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ke-${index + 1}.';

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
    );
  }
}
