import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../domain/use_case/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final role = await loginUseCase.loginAndGetRole(
          event.email,
          event.password,
        );
        emit(LoginSuccess(role));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
