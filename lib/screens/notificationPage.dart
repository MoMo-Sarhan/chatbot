// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/notification.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationContent> Notitem = [
    NotificationContent(
      note: 'mohamed sarhan',
    ),
    NotificationContent(
      note: 'mohamed sarhan',
    ),
    NotificationContent(
      note: 'mohamed sarhan',
    ),
    NotificationContent(
      note: 'mohamed sarhan',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
    NotificationContent(
      note:
          'mohamed sarhanlk ajdfkjakf alkdjf alkdjf lakdjf alkdjf alkdjf lakdjf lakjf alkjf alkj f',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Notifications'),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: Notitem.length,
          itemBuilder: (context, index) => Notitem[index]),
    );
  }
}
