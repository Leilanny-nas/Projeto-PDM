import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                heightFactor: 2,
                child: Text('UruBank',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    )),
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "CPF",
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              Divider(),
              TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: InputDecoration(
                    icon: Icon(Icons.visibility_off_rounded),
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              ButtonTheme(
                height: 60,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
