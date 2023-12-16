// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/screens/SignUpPage.dart';
import 'package:chatbot/screens/mainPage.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;

  void LogIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        await authService.signInWithEmailandPassword(
            emailController.text, passwordController.text);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: AppBar(
        backgroundColor: Color(0xff6229e8),
        title: Center(child: Text('Login')),
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
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: MyBottom(
              ontap: LogIn,
              text: 'Login',
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'forget password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Reset now!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'don\'t have an account yet?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpPage();
                      }));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
