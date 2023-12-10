// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:chatbot/component/PostCard.dart';
import 'package:chatbot/component/communityAppBar.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/postCardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  ScrollController _PostListController = ScrollController();
  bool _isAppBarVisible = true;

  List<PostCardModel> PostCardItems = [
    PostCardModel(
        icon: 'assets/images/icon.png',
        owner: 'Mohamed Sarhan',
        duration: '2 hours ago',
        postImage: 'assets/images/study.jpg',
        mainPost:
            'This is a sample post Replace this with the actual post content'),
    PostCardModel(
        icon: 'assets/images/rate_icons/3.png',
        owner: 'Yousif Ali',
        duration: '2 hours ago',
        mainPost:
            'This is a sample post Replace this with the actual post content'),
    PostCardModel(
        icon: 'assets/images/rate_icons/2.png',
        owner: 'Belal Ahmed',
        postImage: 'assets/images/study2.jpg',
        duration: '2 hours ago',
        mainPost:
            'This is a sample post Replace this with the actual post content'),
    PostCardModel(
        icon: 'assets/images/rate_icons/4.png',
        owner: 'Mohamed Adel',
        duration: '2 hours ago',
        mainPost:
            'This is a sample post Replace this with the actual post content'),
    PostCardModel(
        owner: 'Said',
        icon: 'assets/images/rate_icons/5.png',
        postImage: 'assets/images/study.jpg',
        duration: '2 hours ago',
        mainPost:
            'This is a sample post Replace this with the actual post content'),
  ];

  @override
  void initState() {
    super.initState();
    _PostListController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _PostListController.removeListener(_handleScroll);
    _PostListController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_PostListController.position.outOfRange) {
      if (_PostListController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scrolling down
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      } else if (_PostListController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // Scrolling up
        if (!_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: _isAppBarVisible ? CommunityAppBar(title: 'Coummunity') : null,
      body: ListView.builder(
        controller: _PostListController,
        itemCount: PostCardItems.length, // Adjust the number of posts as needed
        itemBuilder: (context, index) {
          return PostCard(
            post: PostCardItems[index],
          );
        },
      ),
    );
  }
}
