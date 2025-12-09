import 'package:flutter/material.dart';

class DetailInformationPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const DetailInformationPage({
    super.key,
    this.title = "Information",
    this.description =
        "Skin diseases often show visible signs such as unusual discoloration, rashes, itching, dryness, swelling, or texture changes. These symptoms may indicate irritation or infection.",
    this.imageUrl = "https://picsum.dev/image/15/view",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background gradient tetap di Scaffold supaya safe untuk page standalone
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1EA3FF), Color(0xFF7BC9FF), Color(0xFFEAF7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ===== HEADER (perbaikan: Row dengan fixed left/right area) =====
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    // LEFT: back button area (fixed width)
                    SizedBox(
                      width: 56,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            margin: const EdgeInsets.only(left: 12),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 240, 240, 240),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),

                    // CENTER: judul (Expanded, 1 baris, ellipsis)
                    const SizedBox(width: 4),
                    Expanded(
                      child: Center(
                        child: Text(
                          title.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // RIGHT: spacer sama lebar dengan left agar title tetap visual center
                    const SizedBox(width: 56),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ===== ISI KONTEN =====
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // IMAGE dengan tinggi tetap untuk mencegah layout meluber
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200, // batas tinggi supaya tidak makan ruang
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Container(
                              color: Colors.grey[300],
                              child: const Center(child: Icon(Icons.broken_image)),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // WHITE CARD DESCRIPTION
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Information",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
