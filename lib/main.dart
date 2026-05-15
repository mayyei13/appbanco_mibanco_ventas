import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation/app_router.dart';
import 'ui/theme/app_theme.dart';
// Importaciones correctas de tus nuevos ViewModels
import 'viewmodel/auth_oficial_viewmodel.dart';
import 'viewmodel/cartera_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Cambiamos a los nombres de clase que definimos para el Oficial
        ChangeNotifierProvider(
          create: (_) => AuthOficialViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CarteraViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Portal Oficial de Crédito', // Nombre institucional
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.login,
        routes: AppRouter.routes,
      ),
    );
  }
}