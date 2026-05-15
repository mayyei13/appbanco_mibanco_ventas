import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_router.dart';
import 'ui/theme/app_theme.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'viewmodel/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        title: 'Mi Banco',

        theme: AppTheme.lightTheme,

        initialRoute: AppRouter.login,

        routes: AppRouter.routes,

      ),
    );
  }
}