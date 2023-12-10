//ignore_for_file: prefer_const_constructors

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
  final UserProfile userProfile = UserProfile(
    username: 'John Doe',
    bio: 'Flutter Developer',
    profilePictureUrl: 'https://example.com/profile_picture.jpg',
    socialMediaLinks: [
      'https://twitter.com/johndoe',
      'https://github.com/johndoe'
    ],
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/icon.png')),
              SizedBox(height: 16),
              Text(widget.userProfile.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(widget.userProfile.bio, style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Social Media Links',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...widget.userProfile.socialMediaLinks.map(
                (link) => ListTile(
                  title: Text(link),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add custom action when the button is pressed
                },
                child: Text('Custom Action'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
