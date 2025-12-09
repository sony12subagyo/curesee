import 'dart:convert';

import 'package:curesee/features/profile/domain/entities/profil.dart';
import 'package:http/http.dart' as http;

final String baseUrl = "https://060616496327.ngrok-free.app/User";

class ProfileRemoteDataSource {
  Future<List<Profile>> getAllProfile() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((item) {
        return Profile(
          userid: int.tryParse(item['userid']?.toString() ?? "0") ?? 0,
          name: item['name'] ?? "",
          gender: item['gender'] ?? "",
          email: item['email'] ?? "",
          ege: int.tryParse(item['ege']?.toString() ?? "0") ?? 0,
        );
      }).toList();
    } else {
      throw Exception("gagal memuat profile");
    }
  }

  Future<void> updateProfile(int userid, Profile fp) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$userid"),
      headers: {"content-Type": "application/json"},
      body: jsonEncode({
        "userid": fp.userid,
        "name": fp.name,
        "gender": fp.gender,
        "email": fp.email,
        "ege": fp.ege,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("gagal update profile");
    }
  }
}
