class Profile {
  final int id;
  final String name;
  final String gender;
  final String email;
  final int age;

  Profile({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.age,
  });
  Profile copyWith({
    int? id,
    String? name,
    String? gender,
    String? email,
    int? age,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }
}
