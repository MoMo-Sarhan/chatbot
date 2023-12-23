import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              hintNext: 'Last Name',
              obscureText: false),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: MyBottom(
              ontap: () {
                changeName();
                Navigator.pop(context);
              },
              text: 'Submit'),
        )
      ]),
    );
  }

  Future<void> changeName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      if (firstNameConroller.text.isNotEmpty &&
          lastNameConroller.text.isNotEmpty) {
        final data = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid);
        data.update({
          'userName': '${firstNameConroller.text} ${lastNameConroller.text}'
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
