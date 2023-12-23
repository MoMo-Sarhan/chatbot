// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

PreferredSizeWidget CommunityAppBar({required String title,required Function() ontap}) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Add Post',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
      IconButton(
          onPressed: ontap,
          icon: Icon(
            Icons.add,
            size: 30,
            color: Colors.blue,
          ))
    ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    backgroundColor: Color(0xff6229e8),
    title: Center(child: Text(title)),
  );
}
