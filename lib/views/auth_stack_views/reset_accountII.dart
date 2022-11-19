import 'package:flutter/material.dart';
import 'redefine_pass.dart';

class RecuperarContaStepII extends StatefulWidget {
  const RecuperarContaStepII({super.key});

  @override
  _RecuperarContaStepII createState() => _RecuperarContaStepII();
}

class _RecuperarContaStepII extends State<RecuperarContaStepII> {
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
                child: Text('UruBank',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Insira o código enviado",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              ButtonTheme(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 50)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RedefinePass(),
                      ),
                    );
                  },
                  child: const Text(
                    "Próximo",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
