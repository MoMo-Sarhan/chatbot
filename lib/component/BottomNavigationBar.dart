import 'package:chatbot/models/bottomBar.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem bottomNavigationBarItem(
    {required MyBottomBar bar, required int selected}) {
  return BottomNavigationBarItem(
    icon: Icon(
      bar.ImageIcon,
      size: selected == bar.index ? 50 : 30,
      color: selected == bar.index ? Colors.blue : Colors.black,
    ),
    
    label: bar.label,
  );
}
