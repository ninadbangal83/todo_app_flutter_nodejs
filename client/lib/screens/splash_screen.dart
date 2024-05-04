import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter_nodejs/screens/home_screen.dart';
import 'package:todo_app_flutter_nodejs/screens/login_screen.dart';

import '../utils/get_accesstoken.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        final currentContext = context;
        final loggedIn = await isLoggedIn();
        if (!currentContext.mounted) return;
        if (loggedIn) {
          Navigator.pushReplacement(
              currentContext,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              currentContext,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: const Center(
            child: Text(
          "To Do App",
          style: TextStyle(color: Colors.white, fontSize: 50),
        )),
      ),
    );
  }
}
