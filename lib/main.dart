import 'package:flutter/material.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoutes.routes,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Styles.appBackgroundColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
