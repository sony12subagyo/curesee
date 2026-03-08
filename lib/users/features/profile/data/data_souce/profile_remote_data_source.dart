import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:curesee/users/features/profile/domain/entities/profile.dart';
import 'package:curesee/app/config/app_config.dart';

class ProfileRemoteDataSource {
  //final String baseUrl = "https://af41-103-185-27-18.ngrok-free.app/api/profile";
  final String profileUrl = "${AppConfig.profilUrl}";
  final String regisUrl = "${AppConfig.baseUrl}/register";

  /// =========================
  /// GET PROFILE
  /// =========================
  //   Future<Profile> getProfile() async {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       throw Exception("User belum login");
  //     }

  //     final token = await user.getIdToken();

  //     final response = await http.get(
  //       Uri.parse(baseUrl),
  //       headers: {
  //         "Authorization": "Bearer $token",
  //         "Accept": "application/json",
  //       },
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception("Gagal memuat profile (${response.statusCode})");
  //     }

  //     final body = jsonDecode(response.body);

  //     /// 🔥 SUPPORT 2 FORMAT RESPONSE
  //     /// 1. { id, name, gender, age }
  //     /// 2. { user: { id, name, gender, age } }
  //     final data = body['user'] ?? body;

  //     return Profile(
  //       id: data['id'],
  //       name: data['name'] ?? '',
  //       gender: data['gender'] ?? '',
  //       email: data['email'] ?? '',
  //       age: data['age'] ?? 0,
  //     );
  //   }

  //   /// =========================
  //   /// UPDATE PROFILE
  //   /// =========================
  //   Future<void> updateProfile(Profile profile) async {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       throw Exception("User belum login");
  //     }

  //     final token = await user.getIdToken();

  //     final response = await http.put(
  //       Uri.parse(baseUrl),
  //       headers: {
  //         "Authorization": "Bearer $token",
  //         "Accept": "application/json",
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         "name": profile.name,
  //         "gender": profile.gender,
  //         "age": profile.age,
  //       }),
  //     );

  //     if (response.statusCode != 200) {
  //       throw Exception("Gagal update profile (${response.statusCode})");
  //     }
  //   }
  // }

  /// ===============================
  /// GET PROFILE DARI MYSQL
  /// ===============================
  Future<Profile> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User belum login");
    }

    final token = await user.getIdToken(true);

    final response = await http.get(
      Uri.parse(profileUrl),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      /// support 2 format response
      final data = body['user'] ?? body;

      return Profile(
        id: data['id'] ?? 0,
        email: data['email'] ?? "",
        name: data['name'] ?? "",
        gender: data['gender'] ?? "",
        age: data['age'] ?? 0,
      );
    } else {
      throw Exception("Gagal memuat profile (${response.statusCode})");
    }
  }

  /// ===============================
  /// UPDATE PROFILE KE MYSQL
  /// ===============================
  Future<void> updateProfile(Profile fp) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User belum login");
    }

    final token = await user.getIdToken(true);

    final response = await http.put(
      Uri.parse(profileUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"name": fp.name, "gender": fp.gender, "age": fp.age}),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal update profile (${response.statusCode})");
    }
  }
}
