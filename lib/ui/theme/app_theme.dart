import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryColor =
      Color(0xFF00843D);

  static ThemeData lightTheme = ThemeData(

    primaryColor: primaryColor,

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(

      backgroundColor: primaryColor,

      foregroundColor: Colors.white,

    ),

  );

}