import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_sqflite_getx/controllers/auth_controller.dart';
import 'package:login_sqflite_getx/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                begin: Alignment.topLeft,
                end: Alignment.topRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Hello\nSign in!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          color: Color(0xFF0288D1),
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          suffixIcon: Icon(Icons.email_outlined)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                          color: Color(0xFF0288D1),
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          suffixIcon: Icon(Icons.password_outlined)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Color(0xFF0288D1),
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () async {
                        final email = usernameController.text;
                        final password = passwordController.text;

                        if (email.isEmpty || password.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text(
                                        "Silahkan masukkan email dan password anda"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        child: const Text("Ok"),
                                      )
                                    ],
                                  ));
                        } else {
                          authController.login(
                              usernameController.text, passwordController.text);
                        }
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 6),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have account?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Color(0xFF0288D1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
