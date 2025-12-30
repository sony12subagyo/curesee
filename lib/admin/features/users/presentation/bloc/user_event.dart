abstract class UserEvent {}

class LoadUsers extends UserEvent {}
class DeleteUser extends UserEvent {
  final int id;
  DeleteUser(this.id);
}

