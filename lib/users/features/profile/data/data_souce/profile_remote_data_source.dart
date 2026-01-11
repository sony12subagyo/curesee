import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:http/http.dart' as http;



final String baseUrl = "https://9ded6d580cdd.ngrok-free.app/api/profile";



class ProfileRemoteDataSource {
  Future<Profile> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("user belum login");
    }
    final token = await user.getIdToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Profile(
        id: data['id'],
        name: data['name'] ?? "",
        gender: data['gender'] ?? "",
        email: data['email'] ?? "",
        age: data['age'] ?? 0,
      );
    } else {
      throw Exception("gagal memuat profile");
    }
  }

  Future<void> updateProfile(Profile fp) async {
    final user = FirebaseAuth.instance.currentUser!;
    final token = await user.getIdToken();

    final response = await http.put(
      Uri.parse("$baseUrl"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": fp.name, "gender": fp.gender, "age": fp.age}),
    );

    if (response.statusCode != 200) {
      throw Exception("gagal update profile");
    }
  }
}
