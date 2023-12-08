// ignore_for_file: prefer_const_constructors

import 'package:chatbot/main.dart';
import 'package:chatbot/models/settingItem.dart';
import 'package:chatbot/screens/setting_pages/Language_page.dart';
import 'package:chatbot/screens/setting_pages/Rating_Page.dart';
import 'package:chatbot/screens/setting_pages/change_name_page.dart';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  Item({required this.settingItem});
  SettingModel settingItem;
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  void onPressed() {
    setState(() {
      if (this.widget.settingItem.text == 'Change Name') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChangeNamePage()));
      }

      if (this.widget.settingItem.text == 'Apperance') {
        var temp = this.widget.settingItem.icon_1;
        this.widget.settingItem.icon_1 = this.widget.settingItem.icon_2;
        this.widget.settingItem.icon_2 = temp;
      }
      if (this.widget.settingItem.text == 'Language') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LanguagePage()));
      }
      if (this.widget.settingItem.text == 'Get Notifications') {
        notificationFlag = !notificationFlag;
        this.widget.settingItem.icon_1 =
            notificationFlag ? Icons.notifications_active : Icons.notifications;
        this.widget.settingItem.icon_2 = notificationFlag
            ? Icons.toggle_on_rounded
            : Icons.toggle_off_outlined;
      }
      if (this.widget.settingItem.text == 'Rate The App') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RatingPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(children: [
            Spacer(
              flex: 1,
            ),
            Icon(
              this.widget.settingItem.icon_1,
            ),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              width: 100,
              child: Text(
                this.widget.settingItem.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            IconButton(
              onPressed: this.onPressed,
              icon: Icon(
                this.widget.settingItem.icon_2,
              ),
            ),
          ]),
        ),
        Divider(
          color: Colors.amber,
          indent: 75,
          endIndent: 75,
        )
      ],
    );
  }
}
