// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/screens/homePage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: AppBar(
        backgroundColor: Color(0xff6229e8),
        title: Text('Login'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyBottom(
                  ontap: () {},
                  text: 'Sign In',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyBottom(
                  ontap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  },
                  text: 'Login',
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
