import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/api_config.dart';
import '../models/history_scan_model.dart';

class HistoryRemoteApi {
  final Future<String> Function() getToken;

  HistoryRemoteApi({required this.getToken});

  // ==========================
  // GET ALL HISTORY
  // ==========================
  Future<List<HistoryScanModel>> getAllScans() async {
    final token = await getToken();

    final res = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/history'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception("GET history failed: ${res.body}");
    }

    final List data = jsonDecode(res.body);
    return data.map((e) => HistoryScanModel.fromJson(e)).toList();
  }

  // ==========================
  // GET ONE HISTORY
  // ==========================
  Future<HistoryScanModel> getScan(String id) async {
    final token = await getToken();

    final res = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/history/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception("GET detail failed: ${res.body}");
    }

    final data = jsonDecode(res.body);
    return HistoryScanModel.fromJson(data);
  }

  // ==========================
  // DELETE HISTORY
  // ==========================
  Future<void> deleteScan(String id) async {
    final token = await getToken();

    final res = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/history/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception("Delete failed: ${res.body}");
    }
  }

  // ==========================
  // SAVE HISTORY (POST)
  // ==========================
  Future<HistoryScanModel> saveScan({
    required String imagePath,
    required String label,
    required double confidence,
    required String firebaseUid, // tetap dikirim untuk database
  }) async {
    final token = await getToken();

    final uri = Uri.parse('${ApiConfig.baseUrl}/history');

    final request = http.MultipartRequest('POST', uri);

    // 🔐 Firebase JWT → Laravel middleware
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    // Data form
    request.fields['firebase_uid'] = firebaseUid;
    request.fields['label'] = label;
    request.fields['confidence'] = confidence.toString();

    // File
    request.files.add(
      await http.MultipartFile.fromPath('image', imagePath),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Upload failed: ${response.body}");
    }

    final json = jsonDecode(response.body);
    return HistoryScanModel.fromJson(json);
  }
}
