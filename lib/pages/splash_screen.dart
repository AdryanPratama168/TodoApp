import 'package:flutter/material.dart';
import 'package:login_sqflite_getx/pages/onBoarding.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                      size: 100,
                    ),
                    Text(
                      "Todo App",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
            ),
          ),
          Align(
            child: Text("Copyright@2025 Todo app. All right reserved",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
