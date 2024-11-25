import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Home.dart';
import 'login.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() => _GetstartedState();
}

class _GetstartedState extends State<Getstarted> {
  @override
  void initState() {
    super.initState();
    // Check user status after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  // Method to check if a user is logged in
  void _checkUserStatus() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      // Navigate to Home if user is logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      // Log message if no user is logged in
      print("No user logged in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design based on screen size
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    // Dynamic sizing
    double fontSize = width * 0.06;
    double smallFontSize = width * 0.05;
    double buttonHeight = height * 0.07;
    double paddingSize = width * 0.04;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Get Started text
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: Text(
                  'Get started with this minimalistic weather App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03), // Spacing

              // Lottie animation
              SizedBox(
                width: double.infinity,
                height: height * 0.4,
                child: Lottie.asset('assetss/getstarted.json'),
              ),
              SizedBox(height: height * 0.05), // Spacing

              // Get Started Button
              SizedBox(
                width: width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Login Page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF01579B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get started',
                        style: TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
