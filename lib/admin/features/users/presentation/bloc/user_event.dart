abstract class UserEvent {}

class GetUsersRequested extends UserEvent {}

class DeleteUserRequested extends UserEvent {
  final int id;
  DeleteUserRequested(this.id);
}
