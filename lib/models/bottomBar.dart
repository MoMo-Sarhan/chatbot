import 'package:flutter/material.dart';

class MyBottomBar {
  MyBottomBar({
    required this.ImageIcon,
    required this.label,
    required this.onpressed,
    required this.index,
  });
  String? label;
  IconData? ImageIcon;
  int index;
  Function() onpressed;
}
