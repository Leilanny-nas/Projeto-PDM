import 'package:flutter/cupertino.dart';
import 'package:uru_bank/views/auth_stack_views/login.dart';
import 'package:uru_bank/views/auth_stack_views/recover.dart';
import 'package:uru_bank/views/auth_stack_views/signup.dart';
import 'package:uru_bank/views/main_stack_views/account_details.dart';
import 'package:uru_bank/views/main_stack_views/deposit_money.dart';
import 'package:uru_bank/views/main_stack_views/home_view.dart';
import 'package:uru_bank/views/main_stack_views/perfil.dart';
import 'package:uru_bank/views/main_stack_views/send_money_view.dart';
import 'package:uru_bank/views/main_stack_views/settings.dart';
import 'package:uru_bank/views/splash.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const recover = '/recover';
  static const home = '/home';
  static const accountDetails = '/account-details';
  static const sendMoney = '/send-money';
  static const depositMoney = '/deposit-money';
  static const settings = '/settings';
  static const perfil = '/perfil';

  static Map<String, WidgetBuilder> routes = {
    splash: (BuildContext context) => const Splash(),
    login: (BuildContext context) => const Login(),
    signup: (BuildContext context) => const Signup(),
    recover: (BuildContext context) => const Recover(),
    home: (BuildContext context) => const Home(),
    accountDetails: (BuildContext context) => const AccountDetails(),
    sendMoney: (BuildContext context) => const SendMoney(),
    depositMoney: (BuildContext context) => const DepositMoney(),
    settings: (BuildContext context) => const Settings(),
    perfil: (BuildContext context) => const Perfil(),
  };
}
