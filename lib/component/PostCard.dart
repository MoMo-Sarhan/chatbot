// ignore_for_file: prefer_const_constructors

import 'package:chatbot/models/postCardModel.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  PostCard({required this.post});
  PostCardModel post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool flage = false;
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
                  ? AssetImage(widget.post.icon!)
                  : null,
              backgroundColor: Colors.blue,
            ),
            title:
                Text(widget.post.owner), // Replace with the post author's name
            subtitle: Text(widget.post.duration), // Replace with post timestamp
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.post.mainPost,
              style: TextStyle(fontSize: 16),
            ),
          ),
          if (widget.post.postImage != null)
            Image.asset(widget.post.postImage!),
          ButtonBar(
            children: [
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: flage ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    flage = !flage;
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
              IconButton(
                icon: Icon(
                  Icons.share,
                ),
                onPressed: () {
                  // Handle share button action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
