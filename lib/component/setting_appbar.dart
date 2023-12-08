// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

PreferredSizeWidget SettingAppBar({required String title}) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    backgroundColor: Color(0xff6229e8),
    title: Center(child: Text(title)),
  );
}
