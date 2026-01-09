import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../../domain/entities/blog.dart';

class BlogRemoteDatasource {
  final Dio dio;
  BlogRemoteDatasource(this.dio);

  Future<void> createBlog(FormData formData) async {
    await dio.post('/blogs', data: formData);
  }

  Future<List<Blog>> getBlogs() async {
    final res = await dio.get('/blogs');
    final data = res.data as List;

    return data.map((e) {
      return Blog(
        id: e['id'],
        title: e['title'],
        description: e['content'] ?? '', // backend pakai content
        imageUrl: e['image'] ?? '',
      );
    }).toList();
  }

  Future<void> updateBlog(int id, FormData data) async {
    final response = await dio.post(
      '/blogs/$id',
      data: data,
      options: Options(contentType: 'multipart/form-data'),
    );

    debugPrint("UPDATE STATUS: ${response.statusCode}");
    debugPrint("UPDATE DATA: ${response.data}");
  }

  Future<void> deleteBlog(int id) async {
    final response = await dio.delete('/blogs/$id');
    debugPrint('DELETE STATUS: ${response.statusCode}');
  }
}
