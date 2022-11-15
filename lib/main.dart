import 'package:flutter/material.dart';
import 'package:uru_bank/cadastro.dart';
import 'package:uru_bank/index.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Início',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
          )),
      routes: {
        '/': (_) => const Index(),
        '/login': (_) => const Login(),
        '/cadastro': (_) => const Cadastro()
      },
    );
  }
}
