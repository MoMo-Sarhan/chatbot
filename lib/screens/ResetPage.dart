// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Reset Password'),
      body: ListView(children: [
        SizedBox(
          height: 30,
        ),
        MyTextFiled(
            controller: _emailController,
            hintNext: 'Email',
            obscureText: false),
        SizedBox(
          height: 40,
        ),
        MyBottom(ontap: resetPassword, text: 'Reset'),
      ]),
    );
  }

  Future<void> resetPassword() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
        print('reset successufly');
      } catch (e) {
        print(e);
        print('>>>>>>>>>>>>>>>>>>>>>>>>');
      }
    }
  }
}
