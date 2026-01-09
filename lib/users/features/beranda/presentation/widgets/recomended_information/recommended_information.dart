import 'package:flutter/material.dart';
import '../../../domain/entities/beranda.dart';
import '../card_detail_page..dart';

class RecommendedInformation extends StatelessWidget {
  final List<Beranda> blogs;
  final int limit;

  const RecommendedInformation({
    super.key,
    required this.blogs,
    this.limit = 4, // default 4 item terbaru
  });

  @override
  Widget build(BuildContext context) {
    if (blogs.isEmpty) {
      return const SizedBox.shrink();
    }

    final items = blogs.take(limit).toList();

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
            final blog = items[index];

            return InkWell(
              borderRadius: BorderRadius.circular(16),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  blog.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
