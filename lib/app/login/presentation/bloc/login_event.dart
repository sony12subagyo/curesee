abstract class LoginEvent {}

class LoginUserPressed extends LoginEvent {
  final String email;
  final String password;

  LoginUserPressed(this.email, this.password);
}

class LoginAdminPressed extends LoginEvent {
  final String email;
  final String password;

  LoginAdminPressed(this.email, this.password);
}
