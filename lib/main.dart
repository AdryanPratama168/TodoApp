import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/pages/splash_screen.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController()); 
    return GetMaterialApp(
      title: 'Login App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
