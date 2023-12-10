import 'package:flutter/material.dart';

class PostCardModel {
  String owner;
  String duration;
  String mainPost;
  String? postImage;
  String? icon;

  PostCardModel(
      {required this.owner,
      required this.duration,
      required this.mainPost,
      this.icon,
      this.postImage});
}
