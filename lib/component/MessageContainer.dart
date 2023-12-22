// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.message,
    required this.id,
    required this.alignment,
    required this.time,
  });
  final String id;
  final String message;
  final bool alignment;
  final Timestamp time;

  String getTime() {
    DateTime timeData = time.toDate();
    int hour = timeData.hour;
    int second = timeData.second;
    return hour.toString() + ':' + second.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: alignment
          ? EdgeInsets.only(left: 20, bottom: 10, top: 10)
          : EdgeInsets.only(right: 20, bottom: 10, top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: alignment
                ? Color.fromARGB(255, 216, 193, 126)
                : Color.fromARGB(255, 140, 153, 228)),
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.center,
            child: Text(id),
          ),
          Text(message),
          Text(
            getTime(),
            style: TextStyle(color: Colors.blueGrey),
          )
        ]),
      ),
    );
  }
}
