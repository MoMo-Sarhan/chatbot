// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/item.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/settingItem.dart';
import 'package:chatbot/screens/setting_pages/change_name_page.dart';
import 'package:flutter/material.dart';

void onpressed() {}
List<SettingModel> settingItems = [
  SettingModel(
      text: 'Change Name',
      icon_1: Icons.person,
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {}),
  SettingModel(
      text: 'Lock profile',
      icon_1: Icons.lock,
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {}),
  SettingModel(
      text: 'Language',
      icon_1: Icons.language,
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {}),
  SettingModel(
      text: 'Apperance',
      icon_1: Icons.dark_mode_outlined,
      icon_2: Icons.dark_mode,
      onpressed: () {}),
  SettingModel(
      text: 'Rate The App',
      icon_1: Icons.star,
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {}),
  SettingModel(
      text: 'Privcy and Terms',
      icon_1: Icons.person,
      icon_2: Icons.arrow_forward_ios,
      onpressed: () {}),
];

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void change_name() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChangeNamePage();
      }));
    });
  }

  List<Widget> listItem = [
    CircleAvatar(
      radius: 100,
      backgroundColor: Colors.white,
      child: Image(image: AssetImage('assets/images/icon.png')),
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'General Settings',
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
        settingItem: SettingModel(
            text: 'Change Icon',
            icon_1: Icons.person,
            icon_2: Icons.arrow_forward_ios,
            onpressed: () {})),
    Item(
        settingItem: SettingModel(
            text: 'Change Name',
            icon_1: Icons.person,
            icon_2: Icons.arrow_forward_ios,
            onpressed: () {})),
    Item(
        settingItem: SettingModel(
            text: 'Get Notifications',
            icon_1: Icons.notifications,
            icon_2: Icons.toggle_off_outlined,
            onpressed: () {})),
    Item(
        settingItem: SettingModel(
            text: 'Rate The App',
            icon_1: Icons.star,
            icon_2: Icons.arrow_forward_ios,
            onpressed: () {})),
    Item(
        settingItem: SettingModel(
            text: 'Privcy and Terms',
            icon_1: Icons.person,
            icon_2: Icons.arrow_forward_ios,
            onpressed: () {})),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppBar(title: 'Profile'),
      body: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return listItem[index];
          }),
    );
  }
}
