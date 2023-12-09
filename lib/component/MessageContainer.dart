// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, required this.message, required this.id});
  final String id;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: id != 'bot'
          ? EdgeInsets.only(left: 20, bottom: 10, top: 10)
          : EdgeInsets.only(right: 20, bottom: 10, top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: id == 'bot'
                ? Color.fromARGB(255, 216, 193, 126)
                : Color.fromARGB(255, 140, 153, 228)),
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.center,
            child: Text(id),
          ),
          Text(message),
        ]),
      ),
    );
  }
}