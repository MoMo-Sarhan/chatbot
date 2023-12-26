//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatbot/screens/ChatPage.dart';
import 'package:chatbot/screens/chatPage2.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile {
  String username;
  String bio;
  String profilePictureUrl;
  List<String> socialMediaLinks;

  UserProfile({
    required this.username,
    required this.bio,
    required this.profilePictureUrl,
    required this.socialMediaLinks,
  });
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ChooseIcon _chooseIcon = ChooseIcon();
  User? currentUserUid = FirebaseAuth.instance.currentUser;

  String? getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    return user!.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff6229e8),
        body: Stack(
          children: [
            // Image(
            //   image: AssetImage('assets/images/hompagebg2.gif'),
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.fill,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: _chooseIcon.getUserImageUrl(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData) {
                        return CircleAvatar(
                          radius: 100,
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
                Expanded(child: _buildUserList()),
              ],
            ),
          ],
        ));
  }

  Widget _buildUserList() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserUid!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> data = snapshot.data!.data()!;
          return ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 50,
                ),
                title: Text(
                  data['userName'],
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              ListTile(
                leading: data['gender'] == 'male'
                    ? Icon(
                        Icons.male,
                        color: Colors.blue,
                        size: 50,
                      )
                    : Icon(
                        Icons.female,
                        color: Colors.blue,
                        size: 50,
                      ),
                title: Text(
                  data['gender'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.blue,
                  size: 50,
                ),
                title: Text(
                  data['email'],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
            ],
          );
        });
  }
}
