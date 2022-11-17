import 'package:flutter/material.dart';
import 'package:uru_bank/routes/app_routes.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  _Message createState() => _Message();
}

class _Message extends State<Message> {
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
              const Center(
                heightFactor: 2,
                child: Text(
                  'Cadastro efetuado com sucesso!',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              const Center(
                heightFactor: 2,
                child: Text(
                  'Vá para a para a página de login e comece a usar sua conta agora mesmo!',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              ButtonTheme(
                height: 38,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 60)),
                  ),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Divider(),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text(
                    "Sair do app",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
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
