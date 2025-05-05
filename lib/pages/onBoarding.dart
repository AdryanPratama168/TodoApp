import 'package:flutter/material.dart';
import 'package:todo_app/pages/signIn.dart';
import 'package:todo_app/pages/signUp.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                begin: Alignment.topLeft,
                end: Alignment.topRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/logocentang.png",
              height: 60,
              width: 60,
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Todo App",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Welcome back!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60),
                  borderRadius: BorderRadius.circular(30)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn()));
                },
                child: Center(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signUp()));
                },
                child: Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Login with social media",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)),
                  child: Image.asset(
                    "images/instagramlogo.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)),
                  child: Image.asset(
                    "images/facebooklogo.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60)),
                  child: Image.asset(
                    "images/googlelogo.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
