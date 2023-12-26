// ignore_for_file: curly_braces_in_flow_control_structures, use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatbot/component/PostCard.dart';
import 'package:chatbot/component/communityAppBar.dart';
import 'package:chatbot/models/postCardModel.dart';
import 'package:chatbot/reusableFunc.dart';
import 'package:chatbot/screens/AddPostPage.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    setState(() {});
  }

  Future<List<PostCardModel>> getPosts() async {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    QuerySnapshot querySnapshot =
        await posts.orderBy('timestamp', descending: true).get();

    List<PostCardModel> postList = [];

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String url = await _chooseIcon.getImageByUid(uid: data['userId']);
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      bool _ifisLiked = false;
      if (data.containsKey('likesId')) {
        List<dynamic> likesId = data['likesId'];
        if (likesId.contains(currentUserId)) {
          _ifisLiked = true;
        }
      }
      postList.add(PostCardModel(
        numberOfLikes: data['likes'],
        icon: url,
        content: data['content'],
        time: data['timestamp'],
        owner: await getUserName(
          data['userId'],
        ),
        postId: document.id,
        imagePath: await getPostImage(data['userId'], data['image'] ?? ' '),
        ifIsLiked: _ifisLiked,
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
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<PostCardModel> postList = snapshot.data as List<PostCardModel>;
            return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return PostCard(post: postList[index]);
                });
          }
          print(snapshot.error);
          return Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }

  Future<String> getPostImage(String uid, String imageName) async {
    if (imageName.isEmpty) {
      return imageName;
    }
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('user_post_image/${uid}/${imageName}');
    try {
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL ?? '';
    } catch (e) {
      print('Error getting user image URL: $e');
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      // Return a default image URL or handle the error as needed
      return '';
    }
  }
}
