// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/screens/SignUpPage.dart';
import 'package:chatbot/screens/mainPage.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool showPassword = true;


  void SignUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
      } else {
        passwordController.clear();
        confirmPasswordController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: AppBar(
        backgroundColor: Color(0xff6229e8),
        title: Center(child: Text('Sign Up')),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/icon.png',
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          MyTextFiled(
              controller: emailController,
              hintNext: 'Email',
              obscureText: false),
          SizedBox(
            height: 30,
          ),
          MyTextFiled(
            controller: passwordController,
            hintNext: 'Password',
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          MyTextFiled(
            controller: confirmPasswordController,
            hintNext: 'Confirm Password',
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MyBottom(
              ontap: SignUp,
              text: 'Sign Up',
            ),
          ),
        ]),
      ),
    );
  }
}
