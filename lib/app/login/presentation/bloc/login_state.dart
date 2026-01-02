abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final bool isAdmin;

  LoginSuccess({required this.token, required this.isAdmin});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
