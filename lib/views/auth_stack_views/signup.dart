import 'package:flutter/material.dart';
import 'package:uru_bank/components/forms.dart';
import 'package:uru_bank/utils/styles.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Styles.appBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              formHeader(showOnlyLogo: true, logoHeight: 100),
              const SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
