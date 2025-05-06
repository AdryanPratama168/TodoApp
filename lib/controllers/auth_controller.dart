import 'package:get/get.dart';
import 'package:login_sqflite_getx/services/database_helper.dart';
import 'package:login_sqflite_getx/pages/home_page.dart';
import 'package:login_sqflite_getx/pages/login_page.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  login(String username, String password) async {
    var result = await DatabaseHelper.instance.login(username, password);
    if (result != null) {
      isLoggedIn.value = true;
      Get.offAll(() => HomePage()); // Navigasi ke halaman home
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }

  register(String username, String password) async {
    var result = await DatabaseHelper.instance.register(username, password);
    if (result != null) {
      Get.snackbar("Registration", "Registration successful");
      Get.to(() => LoginPage()); // Arahkan ke halaman login setelah registrasi
    }
  }
}
