//ignore_for_file: prefer_const_constructors

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

  String? getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    return user!.email;
  }

  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = UserProfile(
      username: '${getUserEmail()}',
      bio: 'Flutter Developer',
      profilePictureUrl: 'https://example.com/profile_picture.jpg',
      socialMediaLinks: [
        'https://twitter.com/johndoe',
        'https://github.com/johndoe'
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        FutureBuilder(
            future: _chooseIcon.getUserImageUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return CircleAvatar(
                  radius: 70,
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
    ));
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildListItem(DocumentSnapshot docs) {
    Map<String, dynamic> data = docs.data()! as Map<String, dynamic>;
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(
          data['email'],
          style: TextStyle(color: Colors.black),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPage2(
              reciverId: data['uid'],
              reciverEmail: data['email'],
            );
          }));
        },
      );
    } else {
      return Container(
        child: Text('me'),
      );
    }
  }
}
