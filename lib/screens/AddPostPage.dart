// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_null_aware_operators

import 'dart:io';

import 'package:chatbot/component/loginBottom.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _contentConroller = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: SettingAppBar(title: 'Add Post'),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          MyTextFiled(
              controller: _contentConroller,
              hintNext: 'Content',
              obscureText: false),
          SizedBox(
            height: 50,
          ),
          Center(
            child: IconButton(
              onPressed: chooseImage,
              icon: Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MyBottom(ontap: addPost, text: 'Add')
        ],
      ),
    );
  }

  // load image
  Future<void> chooseImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // You can now upload the picked image to Firebase Storage
      imagePath = pickedFile.path;
      print(imagePath);
    }
  }

  Future<void> addPost() async {
    User currentUser = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    String uid = currentUser.uid;
    if (imagePath != null) {
      uploadImage(imagePath!);
    }

    if (_contentConroller.text.isNotEmpty) {
      CollectionReference post = FirebaseFirestore.instance.collection('posts');
      await post.add({
        'userId': uid,
        'content': _contentConroller.text,
        'timestamp': Timestamp.now(),
        'likes': '0',
        'image':imagePath != null? imagePath!.split('/').last: null
      });
      Navigator.pop(context);
    }
  }

  Future<void> uploadImage(String filePath) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String imageName = filePath.split('/').last;

    if (user != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('user_post_image/${user.uid}/$imageName');

      try {
        await storageRef.putFile(File(filePath));
        print('Image uploaded successfully');
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}
