// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:chatbot/component/BottomNavigationBar.dart';
import 'package:chatbot/models/bottomBar.dart';
import 'package:chatbot/screens/CoursesPage.dart';
import 'package:chatbot/screens/commuintyPage.dart';
import 'package:chatbot/screens/homePage.dart';
import 'package:chatbot/screens/loginPage.dart';
import 'package:chatbot/screens/notificationPage.dart';
import 'package:chatbot/screens/settingsPage.dart';
import 'package:chatbot/screens/ChatPage.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['userName'];
        });
      }
    } catch (e) {
      print("Error in getting data from Firestore : $e");
    }
  }

  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> ListPages = [
    HomePage(),
    CommunityPage(),
    ChatPage(),
    SettingsPage(),
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
        label: 'Chat', ImageIcon: Icons.chat, index: 3, onpressed: () {}),
    MyBottomBar(
        label: 'Profile',
        ImageIcon: Icons.person_3_rounded,
        index: 4,
        onpressed: () {})
  ];

  void LogOut() async {
    setState(() {});
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.SignOut();
    FirebaseAuth.instance.signOut();
    print("Sign out successufl");
  }

  ChooseIcon _chooseIcon = ChooseIcon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
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
                    icon: Icon(Icons.notifications, color: Colors.blue)),
                IconButton(
                    onPressed: LogOut,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.blue,
                    )),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder(
                      future: _chooseIcon.getUserImageUrl(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.hasData) {
                          return CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data!),
                          );
                        } else if (snapshot.data == null) {
                          return CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/icon.png',
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/icon.png',
                            ),
                          );
                        }
                      }),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          : null,
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
