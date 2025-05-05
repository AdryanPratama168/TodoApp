import 'package:flutter/material.dart';
import 'package:todo_app/pages/home.dart';
import 'package:todo_app/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Navigasi ke halaman BottomNavBar jika login sukses
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'Pengguna tidak ditemukan!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Password yang dimasukkan salah!';
      } else {
        errorMessage = 'Pengguna atau password yang anda masukkan salah!';
      }

      _showErrorDialog(context, errorMessage);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Gagal'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                        final email = _emailController.text;
                        final password = _passwordController.text;

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
                          return;
                        }
                        _signIn(context);
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
                                      builder: (context) => signUp()));
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
