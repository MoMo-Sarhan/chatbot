// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  MyTextFiled(
      {required this.controller,
      required this.hintNext,
      required this.obscureText});

  final TextEditingController controller;
  final String hintNext;
  bool obscureText;

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      controller: this.widget.controller,
      obscureText: this.widget.obscureText,
      decoration: InputDecoration(
        hintText: this.widget.hintNext,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 130, 138, 212),
        ),
        suffix: this.widget.hintNext == 'Password'
            ? IconButton(
                icon: Icon(widget.obscureText
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
