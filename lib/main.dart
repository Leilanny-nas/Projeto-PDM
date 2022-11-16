import 'package:flutter/material.dart';
import 'package:uru_bank/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Início',
      routes: AppRoutes.routes,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(20, 24, 36, 1),
          ),),
    );
  }
}
