import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../configs/headers.dart';
import '../configs/hosts.dart';

class AuthController {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Call get user API
  static Future<Map<String, dynamic>?> user() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '$host/api/auth/user/';

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
      return null;
    }
  }

  // Call Register API
  static Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      String url = '$host/api/auth/register/';

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
          'username': username,
          'email': email,
          'password': password,
        }),
        headers: headerWithoutToken(),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);

        String token = data['token'];
        _storage.write(
          key: 'token',
          value: token,
        );

        return data['user'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Call Login API
  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      String url = '$host/api/auth/login/';

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: headerWithoutToken(),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        String token = data['token'];
        _storage.write(
          key: 'token',
          value: token,
        );

        return data['user'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Call Logout API
  static Future<bool> logout() async {
    try {
      String? token = await _storage.read(key: 'token');

      if (token != null) {
        String url = '$host/api/auth/logout/';

        Response response = await post(
          Uri.parse(url),
          headers: headerWithToken(token),
        );

        if (response.statusCode == 204) {
          _storage.delete(key: 'token');
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
