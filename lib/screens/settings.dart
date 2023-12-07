// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/item.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<Widget> listItem = [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Genral Settings',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      height: 20,
    ),
    Item(
      icon_1: Icons.person,
      text: 'Change Name',
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {},
    ),
    Item(
        icon_1: Icons.lock,
        text: 'Lock profile',
        icon_2: Icons.arrow_forward_ios,
        onpressed: () {}),
    Item(
        icon_1: Icons.language,
        text: 'Language',
        icon_2: Icons.arrow_forward_ios,
        onpressed: () {}),
    Item(
        icon_1: Icons.dark_mode,
        text: 'Apperance',
        icon_2: Icons.dark_mode_outlined,
        onpressed: () {}),
    Item(
        icon_1: Icons.star,
        text: 'Rate The App',
        icon_2: Icons.arrow_forward_ios,
        onpressed: () {}),
    Item(
        icon_1: Icons.edit_document,
        text: 'Privcy and Terms',
        icon_2: Icons.arrow_forward_ios,
        onpressed: () {})
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: Color(0xff6229e8),
        title: Center(child: Text('Profile')),
      ),
      body: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return listItem[index];
          }),
    );
  }
}
