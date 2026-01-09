import '../../domain/entities/blog.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  BlogLoaded(this.blogs);
}

class BlogSuccess extends BlogState {
  final String message;
  BlogSuccess(this.message);
}

class BlogFailure extends BlogState {
  final String message;
  BlogFailure(this.message);
}
