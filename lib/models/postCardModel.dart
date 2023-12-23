import 'package:cloud_firestore/cloud_firestore.dart';

class PostCardModel {
  String owner;
  Timestamp time;
  String content;
  String? ImagePath;
  String icon;
  String likes;

  PostCardModel(
      {required this.owner,
      required this.time,
      required this.content,
      required this.icon,
      this.ImagePath,
      required this.likes});
}
