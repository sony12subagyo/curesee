abstract class RegistrasiState {}

class RegistrasiInitial extends RegistrasiState {}

class RegistrasiLoading extends RegistrasiState {}

class RegistrasiSuccess extends RegistrasiState {}

class RegistrasiFailure extends RegistrasiState {
  final String message;
  RegistrasiFailure(this.message);
}
