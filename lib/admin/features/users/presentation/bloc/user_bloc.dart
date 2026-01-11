import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<GetUsersRequested>(_onGetUsers);
    on<DeleteUserRequested>(_onDeleteUser);
  }

  Future<void> _onGetUsers(
    GetUsersRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final users = await repository.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserFailure('Gagal mengambil data user'));
    }
  }

  Future<void> _onDeleteUser(
    DeleteUserRequested event,
    Emitter<UserState> emit,
  ) async {
    try {
      await repository.deleteUser(event.id);
      add(GetUsersRequested()); // 🔁 refresh list
    } catch (e) {
      emit(UserFailure('Gagal menghapus user'));
    }
  }
}
