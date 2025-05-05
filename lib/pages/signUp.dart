import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/onBoarding.dart';
import 'package:todo_app/pages/signIn.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final UserCredential userCredential =
        (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text));

    User? user = userCredential.user;

    if (user != Null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Onboarding()));
    }
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
                "Create your\naccount",
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
                      "Name",
                      style: TextStyle(
                          color: Color(0xFF0288D1),
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          hintText: "Enter name",
                          suffixIcon: Icon(Icons.person_2_outlined)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                            "SIGN UP",
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
                        final name = _usernameController.text;

                        if (email.isEmpty || password.isEmpty || name.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text(
                                        "Silahkan masukkan email,password dan nama anda"),
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
                        _register();
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 7),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Already have account?",
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
                                      builder: (context) => signIn()));
                            },
                            child: Text(
                              "SIGN IN",
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
