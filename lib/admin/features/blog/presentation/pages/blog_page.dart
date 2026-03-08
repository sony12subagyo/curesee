import 'package:curesee/admin/features/blog/core/network/admin_dio.dart';
import 'package:curesee/admin/features/blog/data/datasource/blog_remote_datasource.dart';
import 'package:curesee/admin/features/blog/presentation/pages/add_blog_page.dart';
import 'package:curesee/admin/features/blog/presentation/pages/edit_blog.dart';
import 'package:curesee/admin/features/blog/presentation/widgets/blog widget/card_page_admin.dart';
import 'package:curesee/admin/app/navigation/background_wrapper.dart';
import 'package:curesee/admin/features/users/presentation/pages/admin_layout.dart';
import 'package:flutter/material.dart';
import 'package:curesee/app/config/app_config.dart';
import '../../domain/entities/blog.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<List<Blog>> futureBlogs;

  @override
  void initState() {
    super.initState();
    futureBlogs = _fetchBlogs();
  }

  Future<List<Blog>> _fetchBlogs() async {
    final dio = await AdminDio.getInstance();
    final datasource = BlogRemoteDatasource(dio);
    return datasource.getBlogs();
  }

  Future<void> _refreshBlogs() async {
    setState(() {
      futureBlogs = _fetchBlogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      currentIndex: 0,
      child: Stack(
        children: [
          BackgroundWrapper(
            child: SafeArea(
              child: FutureBuilder<List<Blog>>(
                future: futureBlogs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
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

                  return RefreshIndicator(
                    onRefresh: _refreshBlogs,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: blogs.length,
                      itemBuilder: (context, index) {
                        final blog = blogs[index];
                        final imageUrl =
                            "${AppConfig.storageUrl}/${blog.imageUrl}";

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 900 + (index * 130)),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CardPageAdmin(
                              image: NetworkImage(imageUrl),
                              title: blog.title,
                              subtitle: blog.description,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditBlogPage(
                                      id: blog.id,
                                      title: blog.title,
                                      description: blog.description,
                                      imageUrl: imageUrl,
                                    ),
                                  ),
                                );

                                _refreshBlogs();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 0, 128, 255),
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddBlogPage()),
                );

                _refreshBlogs();
              },
            ),
          )
        ],
      ),
    );
  }
}