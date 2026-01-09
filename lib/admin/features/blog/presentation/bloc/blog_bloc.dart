import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/blog_repository.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repository;

  BlogBloc(this.repository) : super(BlogInitial()) {
    on<GetBlogsRequested>(_onGet);
    on<CreateBlogRequested>(_onCreate);
    on<DeleteBlogRequested>(_onDelete);
    on<UpdateBlogRequested>(_onUpdate);
  }

  Future<void> _onGet(GetBlogsRequested event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await repository.getBlogs();
      emit(BlogLoaded(blogs));
    } catch (_) {
      emit(BlogFailure('Gagal mengambil blog'));
    }
  }

  Future<void> _onCreate(CreateBlogRequested event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      await repository.createBlog(
        title: event.title,
        description: event.description,
        image: event.image,
      );
      emit(BlogSuccess('Blog berhasil ditambahkan'));
      add(GetBlogsRequested()); // auto refresh
    } catch (_) {
      emit(BlogFailure('Gagal menambahkan blog'));
    }
  }

  Future<void> _onDelete(DeleteBlogRequested event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      await repository.deleteBlog(event.id);
      emit(BlogSuccess('Blog berhasil dihapus'));
      add(GetBlogsRequested());
    } catch (_) {
      emit(BlogFailure('Gagal menghapus blog'));
    }
  }

  Future<void> _onUpdate(UpdateBlogRequested event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      await repository.updateBlog(
        id: event.id,
        title: event.title,
        description: event.description,
        image: event.image,
      );
      emit(BlogSuccess('Blog berhasil diupdate'));
      add(GetBlogsRequested());
    } catch (_) {
      emit(BlogFailure('Gagal mengupdate blog'));
    }
  }
}
