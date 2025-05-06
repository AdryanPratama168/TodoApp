import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/pages/onBoarding.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController()); // Injeksi awal
    return GetMaterialApp(
      title: 'Login App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
