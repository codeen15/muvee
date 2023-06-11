import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../configs/headers.dart';
import '../configs/hosts.dart';

class ToWatchController {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<Map<String, dynamic>?> addShowToToWatch({
    required int showID,
  }) async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '$host/api/towatch/';

        Response response = await post(
          Uri.parse(url),
          body: jsonEncode({
            'show_id': showID,
          }),
          headers: headerWithToken(token),
        );

        if (response.statusCode == 201) {
          return jsonDecode(response.body);
        }
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<dynamic>?> getAllToWatch() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '$host/api/towatch/';

        Response response = await get(
          Uri.parse(url),
          headers: headerWithToken(token),
        );

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> removeShowFromToWatch({
    required int showID,
  }) async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '$host/api/towatch/$showID/';

        Response response = await delete(
          Uri.parse(url),
          headers: headerWithToken(token),
        );

        if (response.statusCode == 204) {
          return true;
        }
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
