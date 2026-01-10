import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:http/http.dart' as http;

final String baseUrl = "https://e9e47724ef7c.ngrok-free.app/api/profile";

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
        avatarUrl: data['avatar_url'] ?? "",
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

  Future<String> uploadAvatar(File file) async {
    final user = FirebaseAuth.instance.currentUser!;
    final token = await user.getIdToken();

    final uri = Uri.parse("$baseUrl/avatar");

    final request = http.MultipartRequest("POST", uri);
    request.headers["Authorization"] = "Bearer $token";

    request.files.add(await http.MultipartFile.fromPath("avatar", file.path));

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['avatar_url']; // Laravel kirim URL avatar
    } else {
      throw Exception("Upload avatar gagal");
    }
  }
}
