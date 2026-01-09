import 'dart:io';

abstract class BlogEvent {}

class GetBlogsRequested extends BlogEvent {}

class CreateBlogRequested extends BlogEvent {
  final String title;
  final String description;
  final File image;

  CreateBlogRequested({
    required this.title,
    required this.description,
    required this.image,
  });
}

class UpdateBlogRequested extends BlogEvent {
  final int id;
  final String title;
  final String description;
  final File? image;

  UpdateBlogRequested({
    required this.id,
    required this.title,
    required this.description,
    this.image,
  });
}

class DeleteBlogRequested extends BlogEvent {
  final int id;

  DeleteBlogRequested(this.id);
}
