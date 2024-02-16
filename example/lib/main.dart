import 'package:authentication_flow/constants/constants.dart';
import 'package:authentication_flow/presentation/home/home_page.dart';
import 'package:authentication_flow/presentation/login/login_page.dart';
import 'package:authentication_flow/services/auth.dart';
import 'package:authentication_flow/services/dio_service.dart';
import 'package:flutter/material.dart';

void main() {
  DioService.addInterceptors();

  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

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
    isLogged = await Auth().isLogged();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Constants.navKey,
      debugShowCheckedModeBanner: false,
      home: isLogged ? const HomePage() : LoginPage(),
    );
  }
}
