import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? user;

  AuthService() {
    init();
  }

  void init() async {
    Map<String, dynamic>? data = await AuthController.user();

    if (data != null) {
      user = User.fromMap(data);
      notifyListeners();
    }
  }

  Future<String?> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic>? data = await AuthController.register(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
      );

      if (data != null) {
        user = User.fromMap(data);
        notifyListeners();
        return null;
      }

      return 'Error during register';
    } catch (e) {
      return 'Error during register';
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic>? data = await AuthController.login(
        email: email,
        password: password,
      );

      if (data != null) {
        user = User.fromMap(data);
        notifyListeners();
        return null;
      }

      return 'Error during login';
    } catch (e) {
      return 'Error during login';
    }
  }

  Future<String?> logout() async {
    bool res = await AuthController.logout();
    if (res) {
      user = null;
      notifyListeners();

      return null;
    }

    return 'Error logout';
  }
}
