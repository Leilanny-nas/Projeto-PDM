import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/components/form_input.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:uru_bank/utils/validators.dart';

class Recover extends StatefulWidget {
  const Recover({super.key});

  @override
  _Recover createState() => _Recover();
}

class _Recover extends State<Recover> {
  final _formKey = GlobalKey<FormState>();

  void _onPressSend() {
    if (_formKey.currentState!.validate()) {
      // TODO: Add recover credential logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Center(
                  heightFactor: 2,
                  child: Text(
                    'Informe seus dados para que possamos te enviar uma nova senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: formInput(
                    placeholder: "CPF",
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    borderRadius: 4,
                    validator: (String? value) => loginValidation('cpf', value),
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: formInput(
                    placeholder: "Email",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                    borderRadius: 4,
                    validator: (String? value) =>
                        signUpValidation('email', value),
                    sufixIconPadding: const EdgeInsets.only(right: 3),
                  ),
                ),
                const Divider(),
                elevatedButton(
                  context: context,
                  callback: () => _onPressSend,
                  borderRadius: 4,
                  height: 18,
                  color: Styles.buttonPrimaryColor,
                  text: "Enviar",
                  textStyle: const TextStyle(
                    color: Color(0xffE1E1E6),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
