import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/services/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage2 extends StatefulWidget {
  const ChatPage2(
      {super.key, required this.reciverEmail, required this.reciverId});
  final String reciverEmail;
  final String reciverId;

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  TextEditingController _messageConroller = TextEditingController();
  ChatServices _chatServices = ChatServices();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciverEmail),
      ),
      body: Column(
          children: [Expanded(child: _buildListMessage()), _inputTextField()]),
    );
  }

  Widget _inputTextField() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyTextFiled(
              controller: _messageConroller,
              hintNext: 'Enter Message',
              obscureText: false,
            ),
          ),
        ),
        IconButton(
            onPressed: SendMessage,
            icon: Icon(
              Icons.send,
              color: Colors.blue,
              size: 35,
            ))
      ],
    );
  }

  void SendMessage() async {
    setState(() {
      if (_messageConroller.text.isNotEmpty) {
        _chatServices.sendMessage(widget.reciverId, _messageConroller.text);
        _messageConroller.clear();
      }
    });
  }

  Widget _buildListMessage() {
    return StreamBuilder(
        stream: _chatServices.getMessage(
            widget.reciverId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error.toString()}'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Text(data['message']),
    );
  }
}
