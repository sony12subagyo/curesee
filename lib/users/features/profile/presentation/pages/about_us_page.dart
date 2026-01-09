import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 128, 255),
        elevation: 0,
        title: const Text(
          "About us",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 128, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // Judul
                Text(
                  "Tentang CureSee",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                // Isi teks
                Text(
                  "Di CureSee, kami percaya bahwa setiap orang berhak memperoleh "
                  "informasi kesehatan kulit yang mudah, cepat, dan akurat. "
                  "Melalui aplikasi ini, kami menghadirkan teknologi kecerdasan "
                  "buatan untuk membantu pengguna mengenali berbagai masalah "
                  "kulit sejak dini.\n\n"
                  "CureSee dirancang untuk menjadi asisten kesehatan kulit "
                  "yang dapat diandalkan, memberikan edukasi, serta membantu "
                  "pengguna mengambil langkah yang tepat dalam menjaga "
                  "kesehatan kulit mereka.\n\n"
                  "Kami berkomitmen untuk terus mengembangkan CureSee agar "
                  "menjadi solusi digital yang aman, mudah digunakan, dan "
                  "bermanfaat bagi semua.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
