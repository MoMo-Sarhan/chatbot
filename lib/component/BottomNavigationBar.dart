import 'package:chatbot/models/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

GButton bottomNavigationBarItem(
    {required MyBottomBar bar, required int selected}) {
  return GButton(
    onPressed: bar.onpressed,
    icon: bar.ImageIcon!,
    text: bar.label!,
  );
}
