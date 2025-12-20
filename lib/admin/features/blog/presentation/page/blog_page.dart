import 'package:curesee/admin/features/blog/presentation/page/add_blog_page.dart';
import 'package:curesee/admin/features/blog/presentation/widget/card_page_admin.dart';
import 'package:curesee/users/features/beranda/presentation/pages/detail_information_page.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_page.dart';
import 'package:curesee/admin/app/navigation/background_wrapper.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // blog = aktif
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1EA3FF),
        onTap: (index) {
          if (index == 1) {
            // contoh ke halaman admin account
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AdminPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Account',
          ),
        ],
      ),
      // ===== TOMBOL TAMBAH POJOK KANAN BAWAH =====
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1EA3FF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
        
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddBlogPage()),
          );
        },
      ),

      body: BackgroundWrapper(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 8),

                    const Text(
                      'Hallo Admin Curesee',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color.fromARGB(179, 255, 255, 255),
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Information Skin Type',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...List.generate(10, (index) {
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
                    }),
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
