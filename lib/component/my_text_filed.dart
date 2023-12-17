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
        color: Colors.white,
        fontSize: 17,
      ),
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintNext,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 161, 167, 228),
        ),
        suffixIcon: widget.hintNext.toLowerCase() == 'password' ||
                widget.hintNext.toLowerCase() == 'confirm password'
            ? IconButton(
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.blue,
                ),
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
