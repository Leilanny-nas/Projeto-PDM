import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _Cadastro createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  TextEditingController _cpf = TextEditingController();

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
              TextFormField(
                controller: _cpf,
                autofocus: true,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Nome completo",
                    labelStyle: TextStyle(color: Colors.white)),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              Divider(),
              TextFormField(
                controller: _cpf,
                autofocus: true,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "CPF",
                    labelStyle: TextStyle(color: Colors.white)),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              TextFormField(
                controller: _cpf,
                autofocus: true,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    labelText: "Data de nascimento",
                    labelStyle: TextStyle(color: Colors.white)),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
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
              Divider(),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: "Telefone",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
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
              Divider(),
              TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.purple, fontSize: 20),
                decoration: InputDecoration(
                    icon: Icon(Icons.visibility_off_rounded),
                    labelText: "Confirmar senha",
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
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: const Text(
                    "Criar conta",
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
