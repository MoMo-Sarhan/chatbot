// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyBottom extends StatelessWidget {
  const MyBottom({super.key, required this.ontap, required this.text});
  final Function()? ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: this.ontap,
        child: Text(
          this.text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
