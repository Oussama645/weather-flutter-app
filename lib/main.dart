import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Pages/GetStarted.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Getstarted(), // Start from the GetStarted page
    );
  }
}
