// ignore_for_file: curly_braces_in_flow_control_structures, use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatbot/component/PostCard.dart';
import 'package:chatbot/component/communityAppBar.dart';
import 'package:chatbot/models/postCardModel.dart';
import 'package:chatbot/screens/AddPostPage.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  ScrollController _postListController = ScrollController();
  bool _isAppBarVisible = true;
  ChooseIcon _chooseIcon = ChooseIcon();
  @override
  void initState() {
    super.initState();
    _postListController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _postListController.removeListener(_handleScroll);
    _postListController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_postListController.position.outOfRange) {
      if (_postListController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scrolling down
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      } else if (_postListController.position.userScrollDirection ==
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

  void addpost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddPostPage();
    }));
  }

  Future<List<PostCardModel>> getPosts() async {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot =
        await posts.orderBy('timestamp', descending: true).get();

    List<PostCardModel> postList = [];

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String url = await _chooseIcon.getImageByUid(uid: data['userId']);
      postList.add(PostCardModel(
        likes: data['likes'],
        icon: url,
        content: data['content'],
        time: data['timestamp'],
        owner: await getUserName(data['userId']),
      ));
    }

    return postList;
  }

  // Future<QuerySnapshot> getPosts() async {
  //   CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  //   return await posts.orderBy('timestamp', descending: true).get();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: _isAppBarVisible
          ? CommunityAppBar(title: 'Coummunity', ontap: addpost)
          : null,
      body: FutureBuilder(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<PostCardModel> postList = snapshot.data as List<PostCardModel>;
          return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return PostCard(post: postList[index]);
              });
        },
      ),
    );
  }

  Future<String> getUserName(String uid) async {
    try {
      DocumentSnapshot users =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (users.exists) {
        return users['userName'].toString();
      }
    } catch (e) {
      print("from me:$e");
      return null!;
    }
    return null!;
  }
}
