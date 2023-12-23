import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseIcon extends ChangeNotifier {
  Future<void> chooseImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // You can now upload the picked image to Firebase Storage
      String imagePath = pickedFile.path;
      uploadImage(imagePath);
    }
  }

  Future<void> uploadImage(String filePath) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images/${user.uid}/profile_image.jpg');

      try {
        await storageRef.putFile(File(filePath));
        print('Image uploaded successfully');
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<String> getUserImageUrl() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('user_images/${user.uid}/');
      try {
        ListResult result = await storageRef.listAll();
        if (result.items.isNotEmpty) {
          String downloadURL = await result.items.first.getDownloadURL();
          return downloadURL;
        } else {
          return await FirebaseStorage.instance
              .ref()
              .child('default-profile.jpg')
              .getDownloadURL();
        }
      } catch (e) {
        print('Error getting user image URL: $e');
        // Return a default image URL or handle the error as needed
        return await FirebaseStorage.instance
            .ref()
            .child('default-profile.jpg')
            .getDownloadURL();
        ;
      }
    } else {
      // User not authenticated
      return await FirebaseStorage.instance
          .ref()
          .child('default-profile.jpg')
          .getDownloadURL();
    }
  }

  Future<String> getImageByUid({required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('user_images/$uid/');
    try {
      ListResult result = await storageRef.listAll();
      print(result.items);
      if (result.items.isNotEmpty) {
        String downloadURL = await result.items.first.getDownloadURL();
        return downloadURL;
      } else {
        return await FirebaseStorage.instance
            .ref()
            .child('study.jpg')
            .getDownloadURL();
      }
    } catch (e) {
      print('Error getting user image URL: $e');
      // Return a default image URL or handle the error as needed
      return await FirebaseStorage.instance
          .ref()
          .child('study.jpg')
          .getDownloadURL();
    }
  }


  // Send message
}
