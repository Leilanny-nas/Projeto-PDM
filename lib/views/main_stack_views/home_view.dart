import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:uru_bank/routes/app_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(20, 24, 36, 1),
                ),
                child: Text('', textAlign: TextAlign.center)),
            ListTile(
              leading: Icon(Icons.person),
              iconColor: Colors.white,
              title: const Text('Editar perfil'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.lock_person),
              iconColor: Colors.white,
              title: const Text('Configurações'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              iconColor: Colors.white,
              title: const Text('Sair'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
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
                  const Text("Conta",
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
