import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {

  bool loading = false;

  bool success = false;

  String error = '';

  final String correctUser = '12345678';

  final String correctPassword = 'admin123';

  Future<bool> login(
    String user,
    String password,
  ) async {

    loading = true;

    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (
        user == correctUser &&
        password == correctPassword
    ) {

      success = true;

      error = '';

    } else {

      success = false;

      error = 'Credenciales incorrectas';

    }

    loading = false;

    notifyListeners();

    return success;
  }
}