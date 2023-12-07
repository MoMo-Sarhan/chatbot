// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/BottomNavigationBar.dart';
import 'package:chatbot/models/bottomBar.dart';
import 'package:chatbot/models/icons.dart';
import 'package:chatbot/component/Icons.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/models/icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<MyBottomBar> BottomBarIcon = [
    MyBottomBar(
      label: 'home',
      ImageIcon: Icons.home,
      index: 0,
    ),
    MyBottomBar(
      label: 'Books',
      ImageIcon: Icons.book,
      index: 1,
    ),
    MyBottomBar(
      label: 'Courses',
      ImageIcon: Icons.library_books,
      index: 2,
    ),
    MyBottomBar(
      label: 'Chat',
      ImageIcon: Icons.chat,
      index: 3,
    ),
    MyBottomBar(
      label: 'Profile',
      ImageIcon: Icons.person,
      index: 4,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/1.jpg',
              ),
            ),
            Text('Hello,Mohamed Sarhan',style: TextStyle(fontSize: 30,),)
          ],
        ),
      ),
      body: Center(
        child: Text('Your main content goes here'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if(_selectedIndex==BottomBarIcon[1].index){
              Navigator.pushNamed(context,'Books');
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          bottomNavigationBarItem(
              bar: BottomBarIcon[0], selected: _selectedIndex),
          bottomNavigationBarItem(
              bar: BottomBarIcon[1], selected: _selectedIndex),
          bottomNavigationBarItem(
              bar: BottomBarIcon[2], selected: _selectedIndex),
          bottomNavigationBarItem(
              bar: BottomBarIcon[3], selected: _selectedIndex),
          bottomNavigationBarItem(
              bar: BottomBarIcon[4], selected: _selectedIndex),
        ],
      ),
    );
  }
}
