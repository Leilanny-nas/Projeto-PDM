import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uru_bank/app_bar_custom.dart';
import 'RecuperarContaStepI.dart';
import 'home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                heightFactor: 2,
                child: Text('UruBank',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              TextFormField(
                autofocus: true,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "CPF",
                    labelStyle: TextStyle(color: Colors.white)),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              const Divider(),
              TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              ButtonTheme(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(10, 50))),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePage()))),
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(),
              Container(
                height: 40,
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    "Esqueceu sua senha?",
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecuperarContaStepI(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
