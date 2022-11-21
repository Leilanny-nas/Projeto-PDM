import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uru_bank/components/forms.dart';
import 'package:uru_bank/routes/app_routes.dart';
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
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Styles.appBackgroundColor,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(
          parent: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
