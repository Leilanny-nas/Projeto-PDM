import 'package:flutter/material.dart';
import 'package:uru_bank/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Início',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const Index(),
    );
  }
}
