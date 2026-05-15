import 'package:flutter/material.dart';
// Cambia este import por la ruta exacta de tu archivo bueno
import '../view/auth/login_screen.dart'; 
import '../view/home/dashboard_screen.dart';

class AppRouter {
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    dashboard: (context) =>  DashboardScreen(),
  };
}