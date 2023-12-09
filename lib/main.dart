// ignore_for_file: prefer_const_constructors

import 'package:chatbot/screens/homePage.dart';
import 'package:chatbot/screens/loginPage.dart';
import 'package:flutter/material.dart';

bool notificationFlag = true;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
