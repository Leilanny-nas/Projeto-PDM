import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'app_bar_custom.dart';
import 'home_page.dart';

import 'login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  _Cadastro createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  final TextEditingController _cpf = TextEditingController();

  get primary => null;

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
                    labelText: "Nome Completo",
                    labelStyle: TextStyle(color: Colors.white)),
              ),
              const Divider(),
              TextFormField(
                controller: _cpf,
                autofocus: true,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
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
<<<<<<< HEAD
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
=======
              const Divider(),
>>>>>>> e49cf43d47d32cfeb83687509c1d4f98206b902c
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
              const Divider(),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.purple, fontSize: 20),
                decoration: const InputDecoration(
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
              CheckboxListTile(
                title: const Text(
                  'Li e concordo com os Termos e Condições e a Política de Privacidade',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                  selectionColor: Colors.white,
                ),
                value: timeDilation != 1.0,
                onChanged: (bool? value) {
                  setState(() {
                    timeDilation = value! ? 10.0 : 1.0;
                  });
                },
              ),
              ButtonTheme(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 50)),
                  ),
                  onPressed: () {
                    Navigator.push(
<<<<<<< HEAD
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
=======
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomePage())));
>>>>>>> e49cf43d47d32cfeb83687509c1d4f98206b902c
                  },
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
