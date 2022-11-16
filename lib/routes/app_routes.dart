import 'package:flutter/cupertino.dart';
import 'package:uru_bank/views/auth_stack_views/login.dart';
import 'package:uru_bank/views/auth_stack_views/signup.dart';
import 'package:uru_bank/views/main_stack_views/home_view.dart';
import 'package:uru_bank/views/splash.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash: (BuildContext context) => const Splash(),
    login: (BuildContext context) => const Login(),
    signup: (BuildContext context) => const Signup(),
    home: (BuildContext context) => const Home(),
  };
}