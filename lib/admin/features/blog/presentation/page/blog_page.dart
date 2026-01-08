import 'package:curesee/admin/features/blog/core/network/admin_dio.dart';
import 'package:curesee/admin/features/blog/data/datasource/blog_remote_datasource.dart';
import 'package:curesee/admin/features/blog/presentation/page/add_blog_page.dart';
import 'package:curesee/admin/features/blog/presentation/page/edit_blog.dart';
import 'package:curesee/admin/features/blog/presentation/widget/blog%20widget/card_page_admin.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_page.dart';
import 'package:curesee/admin/app/navigation/background_wrapper.dart';
import 'package:curesee/app/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/blog.dart';

class BlogController {
  final BlogRemoteDatasource datasource;

  BlogController(this.datasource);

  Future<List<Blog>> getBlogs() async {
    return await datasource.getBlogs();
  }
}

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  // FUTURE GET BLOGS
  Future<List<Blog>> fetchBlogs() async {
    final dio = await AdminDio.getInstance();
    final datasource = BlogRemoteDatasource(dio);
    final controller = BlogController(datasource);
    return controller.getBlogs();
  }

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

        // ================== KONTEN UTAMA (FutureBuilder) ==================
        Positioned.fill(
          child: FutureBuilder<List<Blog>>(
            future: fetchBlogs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              final blogs = snapshot.data ?? [];

              return ListView(
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

                  ...blogs.map((blog) {
                    final img =
                        "https://dbd21fec81a1.ngrok-free.app/storage/${blog.imageUrl}";

                    return Column(
                      children: [
                        CardPageAdmin(
                          image: NetworkImage(img),
                          title: blog.title,
                          subtitle: blog.description,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditBlogPage(
                                  id: blog.id,
                                  title: blog.title,
                                  description: blog.description,
                                  imageUrl: img,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),

        // ================== LOGOUT BUTTON ==================
        Positioned(
          top: 35,
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
)
,
    );
  }
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

