import 'dart:io';
import 'package:dio/dio.dart';
import '../../domain/entities/blog.dart';
import '../../domain/repository/blog_repository.dart';
import '../datasource/blog_remote_datasource.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource remote;
  BlogRepositoryImpl(this.remote);

  @override
  Future<void> createBlog({
    required String title,
    required String description,
    required File image,
  }) async {
    final formData = FormData.fromMap({
      'title': title,
      'content': description,
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });

    await remote.createBlog(formData);
  }

  @override
  Future<List<Blog>> getBlogs() async {
    return remote.getBlogs();
  }

  @override
  Future<void> deleteBlog(int id) async {
    await remote.deleteBlog(id);
  }

  @override
  Future<void> updateBlog({
    required int id,
    required String title,
    required String description,
    File? image,
  }) async {
    final map = <String, dynamic>{
      '_method': 'PATCH', // penting kalau update pakai upload image
      'title': title,
      'content': description,
    };

    if (image != null) {
      map['image'] = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
    }

    await remote.updateBlog(id, FormData.fromMap(map));
  }
}
