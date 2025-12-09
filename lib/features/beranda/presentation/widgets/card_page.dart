import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final VoidCallback? onTap;

  const CardPage({
    Key? key,
    this.title = "Kriteria Kulit",
    this.subtitle = "Deskripsi singkat...",
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 140, // tetap supaya layout konsisten
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // IMAGE (errorBuilder -> tampilkan placeholder, bukan teks error)
              Image(
                image: image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // placeholder sederhana ketika gagal load
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  );
                },
              ),

              // Overlay gradient: top transparent -> bottom semi-dark
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.55),
                    ],
                    stops: const [0.45, 1.0],
                  ),
                ),
              ),

              // Konten teks di atas overlay
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title (singkat)
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Subtitle (batasi lines)
                    Expanded(
                      child: Text(
                        subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text("more  →",
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
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
