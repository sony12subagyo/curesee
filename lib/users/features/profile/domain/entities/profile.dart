class Profile {
  final int id;
  final String name;
  final String email;
  final String gender;
  final int age;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
  });
  Profile copyWith({
    int? id,
    String? name,
    String? email,
    String? gender,
    int? age,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
    );
  }
}
