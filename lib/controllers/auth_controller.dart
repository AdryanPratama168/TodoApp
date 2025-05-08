import 'package:get/get.dart';
import 'package:login_sqflite_getx/services/database_helper.dart';
import 'package:login_sqflite_getx/pages/home_page.dart';
import 'package:login_sqflite_getx/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  login(String username, String password) async {
    var result = await DatabaseHelper.instance.login(username, password);
    if (result != null) {
      isLoggedIn.value = true;
      Get.snackbar(
        "Login Successful",
        "Welcome back, $username!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
      );
      Get.offAll(() => HomePage()); // Navigasi ke halaman home
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid username or password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    }
  }

 register(String username, String password) async {
  var result = await DatabaseHelper.instance.register(username, password);
  if (result != null) {
    Get.snackbar(
      "Registration Success",
      "Your account has been created successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[800],
    );
    Get.to(() => LoginPage()); // Arahkan ke halaman login setelah registrasi
  } else {
    Get.snackbar(
      "Registration Failed",
      "Username might already exist",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
    );
  }
}
}