// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatbot/component/BottomNavigationBar.dart';
import 'package:chatbot/models/bottomBar.dart';
import 'package:chatbot/screens/CoursesPage.dart';
import 'package:chatbot/screens/commuintyPage.dart';
import 'package:chatbot/screens/homePage.dart';
import 'package:chatbot/screens/loginPage.dart';
import 'package:chatbot/screens/notificationPage.dart';
import 'package:chatbot/screens/settingsPage.dart';
import 'package:chatbot/screens/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> ListPages = [
    HomePage(),
    CommunityPage(),
    CoursesPage(),
    ChatPage(),
    Settings(),
  ];
  List<MyBottomBar> BottomBarIcon = [
    MyBottomBar(
        label: 'home', ImageIcon: Icons.home, index: 0, onpressed: () {}),
    MyBottomBar(
        label: 'Community',
        ImageIcon: Icons.people_alt,
        index: 1,
        onpressed: () {}),
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
      appBar: _selectedIndex == 4 ||
              _selectedIndex == 3 ||
              _selectedIndex == 2 ||
              _selectedIndex == 1
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
                        return NotificationPage();
                      }));
                    },
                    icon: Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    icon: Icon(Icons.logout)),
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
                    'Mohamed Sarhan',
                    style: TextStyle(
                      color: Colors.black,
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
        tabBorder: Border.all(strokeAlign: 0),
        tabBackgroundColor: Color(0xff6229e8),
        selectedIndex: _selectedIndex,
        padding: EdgeInsets.all(16),
        gap: 8,
        tabs: BottomBarIcon.map((bottomBar) => bottomNavigationBarItem(
            bar: bottomBar, selected: _selectedIndex)).toList(),
      ),
    );
  }
}
