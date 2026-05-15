import 'package:flutter/material.dart';
// Asegúrate de que estas rutas coincidan exactamente con la ubicación de tus archivos
import '../view/auth/login_oficial_screen.dart'; 
import '../view/home/cartera_diaria_screen.dart';

class AppRouter {
  static const String login = '/';
  static const String cartera = '/cartera'; // Cambiamos el nombre para que sea más descriptivo

  static Map<String, WidgetBuilder> routes = {
    // Aquí usamos los nombres de las clases que definimos en los pasos anteriores
    login: (context) => const LoginOficialScreen(),
    cartera: (context) => const CarteraDiariaScreen(),
  };
}