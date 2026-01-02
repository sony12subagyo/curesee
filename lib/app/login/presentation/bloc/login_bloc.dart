import 'package:curesee/app/login/domain/use_case/admin_login_usecase.dart';
import 'package:curesee/app/login/domain/use_case/user_login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase userLoginUsecase;
  final AdminLoginUsecase adminLoginUsecase;

  LoginBloc({required this.userLoginUsecase, required this.adminLoginUsecase})
    : super(LoginInitial()) {
    // ================= USER LOGIN =================
    on<LoginUserPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await userLoginUsecase.execute(
          event.email,
          event.password,
        );

        // 🔥 SIMPAN TOKEN USER
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        emit(LoginSuccess(token: token, isAdmin: false));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });

    // ================= ADMIN LOGIN =================
    on<LoginAdminPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await adminLoginUsecase.execute(
          event.email,
          event.password,
        );

        // 🔥🔥🔥 INI YANG KEMARIN HILANG 🔥🔥🔥
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('admin_token', token);

        emit(LoginSuccess(token: token, isAdmin: true));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
