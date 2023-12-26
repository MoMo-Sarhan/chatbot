// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/commentCard.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/commentModel.dart';
import 'package:chatbot/models/message.dart';
import 'package:chatbot/reusableFunc.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({required this.postId});
  final String postId;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _controller = TextEditingController();
  ChooseIcon _chooseIcon = ChooseIcon();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Comments'),
      body: Column(children: [
        // adding list builder
        // adding new comment
        Expanded(child: _buildCommentsList()),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextFiled(
                    controller: _controller,
                    hintNext: 'comment',
                    obscureText: false),
              ),
            ),
            IconButton(
                onPressed: addComment,
                icon: Icon(
                  Icons.send,
                  size: 40,
                  color: Colors.blue,
                ))
          ],
        )
      ]),
    );
  }

  Future<List<CommentModel>> getComments() async {
    var selectedPost =
        FirebaseFirestore.instance.collection('posts').doc(widget.postId);
    var checkComments = await selectedPost.get();
    if (!checkComments.data()!.containsKey('comments')) {
      selectedPost.collection('comments');
    }
    var commentsCollection = selectedPost.collection('comments');
    QuerySnapshot querySnapshot =
        await commentsCollection.orderBy('timestamp', descending: true).get();

    List<CommentModel> postList = [];

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String userIcon = await _chooseIcon.getImageByUid(uid: data['uid']) ?? '';
      String time = getTime(data['timestamp']) ?? '';
      String userName = await getUserName(data['uid']) ?? '';
      String content = data['content'] ?? '';
      String userUid = data['uid'] ?? '';
      print('userIcon:$userIcon');
      print('time:$time');
      print('content:$content');
      print('userUid:$userUid');
      print('userName:$userName');

      postList.add(CommentModel(
        content: content,
        time: time,
        uid: userUid,
        userIcon: userIcon,
        userName: userName,
      ));
    }

    return postList;
  }

  Widget _buildCommentsList() {
    return FutureBuilder(
        future: getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CommentCard(comment: snapshot.data![index]);
              });
        });
  }

  Future<void> addComment() async {
    setState(() {});
    if (_controller.text.isNotEmpty) {
      var post =
          FirebaseFirestore.instance.collection('posts').doc(widget.postId);
      var comment = await post.get();
      if (!comment.data()!.containsKey('comments')) {
        post.collection('comments');
      }
      post.collection('comments').add({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'content': _controller.text,
        'timestamp': Timestamp.now()
      });
      _controller.clear();
    }
  }
}
