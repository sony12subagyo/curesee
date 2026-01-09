import 'dart:io';
import '../entities/blog.dart';

abstract class BlogRepository {
  Future<void> createBlog({
    required String title,
    required String description,
    required File image,
  });

  Future<void> updateBlog({
    required int id,
    required String title,
    required String description,
    File? image,
  });

  Future<void> deleteBlog(int id);

  Future<List<Blog>> getBlogs();
}
