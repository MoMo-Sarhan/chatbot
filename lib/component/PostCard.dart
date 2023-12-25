// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:chatbot/models/postCardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  PostCard({required this.post});
  PostCardModel post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool? flage;

  @override
  void initState() {
    super.initState();
    flage = widget.post.ifIsLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 149, 179, 207),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            tileColor: Color.fromARGB(255, 10, 77, 139),
            leading: CircleAvatar(
              // You can replace this with user profile image

              backgroundImage: widget.post.icon != null
                  ? NetworkImage(widget.post.icon)
                  : null,
            ),
            title:
                Text(widget.post.owner), // Replace with the post author's name
            subtitle: Text(
              getTime(widget.post.time),
              style: TextStyle(color: Colors.amber),
            ), // Replace with post timestamp
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.post.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
          if (widget.post.imagePath.isNotEmpty)
            Image.network(widget.post.imagePath),
          ButtonBar(
            children: [
              Text(widget.post.numberOfLikes),
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: flage! ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    flage = !flage!;
                    addLike();
                  });
                  // Handle like button action
                },
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {
                  // Handle comment button action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getTime(Timestamp time) {
    DateTime timeData = time.toDate();
    int hour = timeData.hour;
    int second = timeData.second;
    int day = timeData.day;
    int month = timeData.month;
    int year = timeData.year;
    return '$hour:$second $day/$month/$year';
  }

  Future<void> addLike() async {
    int newlikes = int.parse(widget.post.numberOfLikes);
    if (flage!) {
      newlikes = newlikes + 1;
    } else {
      newlikes = newlikes - 1;
    }
    widget.post.numberOfLikes = newlikes.toString();
    var selectedPost =
        FirebaseFirestore.instance.collection('posts').doc(widget.post.postId);
    await selectedPost.update({'likes': newlikes.toString()});

    // add the user in the likesid filed
    // get the fileds of the post
    var posts = await selectedPost.get();
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (posts.data()!.containsKey('likesId')) {
      List<dynamic> likesId = posts['likesId'];
      if (!flage!) {
        likesId.remove(currentUserId);
      } else {
        likesId.add(currentUserId);
      }
      selectedPost.update({
        'likesId': likesId,
      });
    } else {
      selectedPost.update({
        'likesId': <String>[currentUserId],
      });
    }
  }
}
