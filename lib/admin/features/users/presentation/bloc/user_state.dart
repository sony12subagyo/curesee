import '../../domain/entities/user_entity.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserFailure extends UserState {
  final String message;
  UserFailure(this.message);
}
