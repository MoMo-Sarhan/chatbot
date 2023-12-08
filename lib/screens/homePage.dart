// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/BottomNavigationBar.dart';
import 'package:chatbot/models/bottomBar.dart';
import 'package:chatbot/models/icons.dart';
import 'package:chatbot/component/Icons.dart';
import 'package:chatbot/screens/login.dart';
import 'package:chatbot/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/models/icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> ListPages = [
    Center(
      child: Text('Home Page'),
    ),
    Center(
      child: Text('Books Page'),
    ),
    Center(
      child: Text('Courses Progress'),
    ),
    Center(
      child: Text('Chat bot'),
    ),
    Settings(),
  ];
  List<MyBottomBar> BottomBarIcon = [
    MyBottomBar(
        label: 'home', ImageIcon: Icons.home, index: 0, onpressed: () {}),
    MyBottomBar(
        label: 'Books', ImageIcon: Icons.book, index: 1, onpressed: () {}),
    MyBottomBar(
        label: 'Courses',
        ImageIcon: Icons.library_books,
        index: 2,
        onpressed: () {}),
    MyBottomBar(
        label: 'Chat', ImageIcon: Icons.chat, index: 3, onpressed: () {}),
    MyBottomBar(
        label: 'Profile',
        ImageIcon: Icons.person_3_rounded,
        index: 4,
        onpressed: () {})
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 4
          ? null
          : AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              backgroundColor: Color(0xff6229e8),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    icon: Icon(Icons.login)),
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/icon.png',
                    ),
                  ),
                  Text(
                    'Hello,Mohamed Sarhan',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
      body: PageView.builder(
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: _pageController,
          itemCount: ListPages.length,
          itemBuilder: (context, index) {
            return ListPages[index];
          }),
      bottomNavigationBar: GNav(
        activeColor: Colors.blue,
        onTabChange: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: Duration(microseconds: 500), curve: Curves.easeInOut);
          });
        },
        backgroundColor: Colors.white,
        tabBackgroundColor: Color(0xff6229e8),
        selectedIndex: _selectedIndex,
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: BottomBarIcon.map((bottomBar) => bottomNavigationBarItem(
            bar: bottomBar, selected: _selectedIndex)).toList(),

        // [
        //   bottomNavigationBarItem(
        //       bar: BottomBarIcon[0], selected: _selectedIndex),
        //   bottomNavigationBarItem(
        //       bar: BottomBarIcon[1], selected: _selectedIndex),
        //   bottomNavigationBarItem(
        //       bar: BottomBarIcon[2], selected: _selectedIndex),
        //   bottomNavigationBarItem(
        //       bar: BottomBarIcon[3], selected: _selectedIndex),
        //   bottomNavigationBarItem(
        //       bar: BottomBarIcon[4], selected: _selectedIndex),
        // ]
      ),
    );
  }
}
