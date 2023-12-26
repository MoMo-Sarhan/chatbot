import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String uid;
  String userName;
  String userIcon;
  String content;
  String time;
  CommentModel({
    required this.uid,
    required this.content,
    required this.time,
    required this.userIcon,
    required this.userName,
  });
}
