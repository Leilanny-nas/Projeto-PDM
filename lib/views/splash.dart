import 'package:flutter/material.dart';
import 'package:uru_bank/components/buttons.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 24, 36, 1),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(
          parent: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 170,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      'UruBank',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 35,
                        bottom: 26,
                        left: 20,
                        right: 20,
                      ),
                      child: elevatedButton(
                        context: context,
                        callback: () =>
                            Navigator.pushNamed(context, AppRoutes.login),
                        borderRadius: 10,
                        height: 18,
                        color: Styles.buttonPrimaryColor,
                        text: "Entrar",
                        textStyle: const TextStyle(
                          color: Color(0xffE1E1E6),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: outlinedButton(
                        context: context,
                        callback: () =>
                            Navigator.pushNamed(context, AppRoutes.signup),
                        borderRadius: 10,
                        height: 18,
                        color: Colors.transparent,
                        text: "Criar conta",
                        textStyle: const TextStyle(
                          color: Color(0xffE1E1E6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
