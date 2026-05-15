import 'package:flutter/material.dart';

class AuthOficialViewModel extends ChangeNotifier {
  bool loading = false;
  bool success = false;
  String error = '';

  // CREDENCIALES HARDCODEADAS PARA EL OFICIAL
  final String correctEmployeeCode = 'OFICIAL123'; 
  final String correctPassword = 'admin2024';

  Future<bool> login(
    String codigo,
    String password,
  ) async {
    loading = true;
    error = ''; // Limpiamos errores previos
    notifyListeners();

    // Simulamos la espera de red
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (codigo == correctEmployeeCode && password == correctPassword) {
      success = true;
      error = '';
    } else {
      success = false;
      error = 'Código de empleado o contraseña incorrectos';
    }

    loading = false;
    notifyListeners();
    return success;
  }
}