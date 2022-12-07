import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uru_bank/components/bottom_modal.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/components/form_input.dart';
import 'package:uru_bank/components/forms.dart';
import 'package:uru_bank/components/snackbar_message.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/services/auth_service.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:uru_bank/utils/validators.dart';

class Recover extends StatefulWidget {
  const Recover({super.key});

  @override
  _Recover createState() => _Recover();
}

class _Recover extends State<Recover> {
  final _formKey = GlobalKey<FormState>();

  bool isRequestingRecover = false;

  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();

  void _onPressSend() {
    if (_formKey.currentState!.validate()) {
      setState(() => isRequestingRecover = true);

      final cpf = _cpfController.text.replaceAll(RegExp(r'(\D)'), '');
      final email = _emailController.text;

      AuthService.recover(cpf, email).then((response) {
        if (response.error) {
          showSnackbarMessage(
            context: context,
            message: response.message,
            ok: true,
            error: true,
            duration: 5,
          );

          setState(() => isRequestingRecover = false);
        } else {
          setState(() => isRequestingRecover = false);

          showBottomModal(
            context,
            height: 300,
            backgroundColor: Colors.white,
            topBorderRadius: 10,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Te enviamos um email",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Styles.buttonPrimaryColor,
                    ),
                  ),
                  Text(
                    "Verifique a caixa de entrada do seu email!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Styles.appBackgroundColor,
                    ),
                  ),
                  elevatedButton(
                    context: context,
                    callback: () => Navigator.popUntil(
                        context, ModalRoute.withName(AppRoutes.login)),
                    borderRadius: 10,
                    height: 18,
                    color: Styles.buttonPrimaryColor,
                    text: "Ir para Login",
                    textStyle: const TextStyle(
                      color: Color(0xffE1E1E6),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    } else {
      setState(() => isRequestingRecover = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    formHeader(showOnlyLogo: true),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        'Olá, vamos recuperar sua conta?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Comece nos dando algumas informações sobre sua conta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
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
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (String? value) {
                          if (_cpfController.text.isEmpty) {
                            return loginValidation('cpf', value);
                          } else if (_cpfController.text.length == 14 &&
                              !CPFValidator.isValid(value)) {
                            return "CPF inválido";
                          } else {
                            return null;
                          }
                        },
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        controller: _cpfController,
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
                        validator: (String? value) =>
                            signUpValidation('email', value),
                        sufixIconPadding: const EdgeInsets.only(right: 3),
                        controller: _emailController,
                      ),
                    ),
                    const Divider(),
                    isRequestingRecover
                        ? animatedButton(
                            context: context,
                            color: Styles.buttonPrimaryColor,
                            borderRadius: 10,
                          )
                        : elevatedButton(
                            context: context,
                            callback: _onPressSend,
                            borderRadius: 10,
                            height: 18,
                            color: Styles.buttonPrimaryColor,
                            text: "Enviar",
                            textStyle: const TextStyle(
                              color: Color(0xffE1E1E6),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        '* Você receberá um email com instruções para recuperar sua senha.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
