import 'package:curesee/admin/features/blog/presentation/page/add_blog_page.dart';
import 'package:curesee/admin/features/blog/presentation/page/edit_blog.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20widget/card_page_admin.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_page.dart';
import 'package:curesee/admin/app/navigation/background_wrapper.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1EA3FF),
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AdminPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Account'),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1EA3FF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBlogPage()),
          );
        },
      ),

      body: BackgroundWrapper(
        child: SafeArea(
          child: Stack(
            children: [
              // ================== KONTEN UTAMA ==================
              Column(
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
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),

                        const SizedBox(height: 16),

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
                                      builder: (_) => EditBlogPage(
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

              // ================== LOGOUT BUTTON (ANIMASI) ==================
              Positioned(
                top: 35, // ⬅️ INI KUNCINYA (posisi ideal)
                right: 16,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _showLogoutDialog(context),
                    splashColor: Colors.white24,
                    child: AnimatedScale(
                      scale: 1.0,
                      duration: const Duration(milliseconds: 120),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== DIALOG LOGOUT ==================
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _logout(context);
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  // ================== LOGIC LOGOUT ==================
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }
}
