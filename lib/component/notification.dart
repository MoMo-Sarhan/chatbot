// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key, required this.note});
  final String note;

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  MaterialStatesController controller = MaterialStatesController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(1, 78, 13, 231)),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        child: Text(
          widget.note,
          style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
