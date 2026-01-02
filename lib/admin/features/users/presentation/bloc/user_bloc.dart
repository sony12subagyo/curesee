import 'package:curesee/admin/features/users/domain/usecase/delete_users_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserBloc({required this.getUsersUseCase, required this.deleteUserUseCase})
    : super(UserLoading()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await getUsersUseCase();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      try {
        await deleteUserUseCase(event.id);
        final users = await getUsersUseCase();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
