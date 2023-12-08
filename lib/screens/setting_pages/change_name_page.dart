import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:flutter/material.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({super.key});

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final TextEditingController firstNameConroller = TextEditingController();
  final TextEditingController lastNameConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Change Name'),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MyTextFiled(
              controller: firstNameConroller,
              hintNext: 'First Name',
              obscureText: false),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MyTextFiled(
              controller: lastNameConroller,
              hintNext: 'First Name',
              obscureText: false),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: MyBottom(
              ontap: () {
                Navigator.pop(context);
              },
              text: 'Submit'),
        )
      ]),
    );
  }
}
