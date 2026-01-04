import 'package:curesee/users/features/beranda/presentation/pages/detail_information_page.dart';
import 'package:curesee/users/features/beranda/presentation/widgets/card_detail_page..dart';
import 'package:flutter/material.dart';

class RecommendedInformation extends StatelessWidget {
  const RecommendedInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'title': 'Informasi Terbaru',
        'subtitle': 'Ini nanti isi nya informasi terbaru yang udah di tambahin ya',
        'imageUrl': 'https://picsum.photos/id/1005/400/300',
      },
      {
        'title': 'Informasi Terbaru',
        'subtitle': 'Ini nanti isi nya informasi terbaru yang udah di tambahin ya',
        'imageUrl': 'https://picsum.photos/id/1011/400/300',
      },
      {
        'title': 'Informasi Terbaru',
        'subtitle': 'Ini nanti isi nya informasi terbaru yang udah di tambahin ya',
        'imageUrl': 'https://picsum.photos/id/1018/400/300',
      },
      {
        'title': 'Informasi Terbaru',
        'subtitle': 'Ini nanti isi nya informasi terbaru yang udah di tambahin ya',
        'imageUrl': 'https://picsum.photos/id/1025/400/300',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Intip Informasi Terbaru!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),

        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, index) {
            final item = items[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardDetail(
                      title: item['title']!,
                      description: item['subtitle']!,
                      imageUrl: item['imageUrl']!,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item['imageUrl']!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
