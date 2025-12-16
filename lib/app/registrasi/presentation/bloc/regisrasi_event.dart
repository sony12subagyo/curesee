abstract class RegistrasiEvent {}

class RegistrasiSubmitted extends RegistrasiEvent {
  final String name, email, gender, password;
  final int age;

  RegistrasiSubmitted({
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.password,
  });
}
