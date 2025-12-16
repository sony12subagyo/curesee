import 'package:curesee/app/login/domain/use_case/login_usecase.dart';
import 'package:curesee/app/login/presentation/bloc/login_event.dart';
import 'package:curesee/app/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        final result = await loginUseCase.execute(event.email, event.password);

        final role = result['role'] as String;

        emit(LoginSuccess(role));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
