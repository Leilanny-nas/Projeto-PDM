import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uru_bank/firebase_options.dart';
import 'package:uru_bank/routes/app_routes.dart';
import 'package:uru_bank/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:uru_bank/providers/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        ),
      ],
      child: MaterialApp(
        routes: AppRoutes.routes,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Styles.appBackgroundColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
