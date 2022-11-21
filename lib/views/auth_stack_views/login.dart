import 'package:flutter/material.dart';
import 'package:uru_bank/components/forms.dart';
import 'package:uru_bank/utils/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.appBackgroundColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(
          parent: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                formHeader(),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
