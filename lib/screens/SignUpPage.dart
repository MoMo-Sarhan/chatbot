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
  final userNameController = TextEditingController();
  bool showPassword = true;

  void SignUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          userNameController.text.isNotEmpty) {
        if (passwordController.text == confirmPasswordController.text) {
          await authService.signUpWithEmailAndPassword(emailController.text,
              passwordController.text, userNameController.text,gender);
        } else {
          passwordController.clear();
          confirmPasswordController.clear();
        }

        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  List<String> genderOptions = ['male', 'female'];
  String gender = 'male';

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
          ListTile(
            leading: Text(
              'Gender',
              style: TextStyle(color: Colors.grey, fontSize: 19),
            ),
            title: DropdownButton(
                dropdownColor: Colors.green,
                value: gender,
                items: genderOptions.map((String item) {
                  return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                }),
          ),
          SizedBox(
            height: 30,
          ),
          MyTextFiled(
              controller: userNameController,
              hintNext: 'User Name',
              obscureText: false),
          SizedBox(
            height: 30,
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
