import 'package:flutter/material.dart';
import 'RecuperarContaStepII.dart';

class RecuperarContaStepI extends StatefulWidget {
  const RecuperarContaStepI({super.key});

  @override
  _RecuperarContaStepI createState() => _RecuperarContaStepI();
}

class _RecuperarContaStepI extends State<RecuperarContaStepI> {
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
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Divider(),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              ButtonTheme(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(10, 50)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecuperarContaStepII(),
                      ),
                    );
                  },
                  child: const Text(
                    "Enviar código",
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
