import 'package:cloud_firestore/cloud_firestore.dart';

class PostCardModel {
  String owner;
  Timestamp time;
  String content;
  String imagePath;
  String icon;
  String likes;

  PostCardModel(
      {required this.owner,
      required this.time,
      required this.content,
      required this.icon,
      required this.imagePath,
      required this.likes});
}
