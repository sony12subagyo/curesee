class Profile {
  final int userid;
  final String name;
  final String gender;
  final String email;
  final int ege;

  Profile({
    required this.userid,
    required this.name,
    required this.gender,
    required this.email,
    required this.ege,
  });
  Profile copyWith({
    int? userid,
    String? name,
    String? gender,
    String? email,
    int? ege,
  }) {
    return Profile(
      userid: userid ?? this.userid,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      ege: ege ?? this.ege,
    );
  }
}
