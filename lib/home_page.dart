import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uru_bank/app_bar_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              const Center(
                heightFactor: 2,
                child: Text('Olá, Username!',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    )),
              ),
              Column(
                children: [
                  Text("Conta",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      )),
                  InkWell(
                    child: Row(children: const [
                      Expanded(flex: 5, child: Icon(Icons.arrow_forward_ios)),
                    ]),
                  )
                ],
              )
            ])),
      ),
    );
  }
}
