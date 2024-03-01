import 'package:example/constants/constants.dart';
import 'package:example/di/di.dart';
import 'presentation/home/home_page.dart';
import 'presentation/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLogged = false;

  @override
  void initState() {
    super.initState();
    _initialSteps();
  }

  void _initialSteps() async {
    // Inicializar Di antes de acceder a sus propiedades
    Di().setContext(context);

    if (Di().authenticator != null) {
      bool loggedIn = await Di().authenticator!.isLogged();
      setState(() {
        isLogged = loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // No es necesario inicializar Di en el método build
    return MaterialApp(
      navigatorKey: Constants.navKey,
      debugShowCheckedModeBanner: false,
      home: isLogged ? const HomePage() : LoginPage(),
    );
  }
}