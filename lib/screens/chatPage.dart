// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  ScrollController _listViewController = ScrollController();
  List<MyContainer> MessageItem = [
    MyContainer(message: 'Welcome', id: 'bot'),
    MyContainer(message: 'welcome', id: 'Mohamed'),
  ];

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        MessageItem.add(
            MyContainer(message: _messageController.text, id: 'User'));

        _messageController.clear();
        _listViewController.animateTo(
            _listViewController.position.maxScrollExtent,
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 200));

        Future.delayed(Duration(seconds: 3));
        MessageItem.add(MyContainer(message: 'No Response ', id: 'bot'));
      });
    }

    if (_messageController.text.isNotEmpty) {}
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Chat Bot'),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return ListView.builder(
        controller: _listViewController,
        itemCount: MessageItem.length,
        itemBuilder: (context, index) => MessageItem[index]);
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextFiled(
            controller: _messageController,
            hintNext: 'Enter Message',
            obscureText: false,
          ),
        ),
        // send bottuon
        IconButton(
          onPressed: sendMessage,
          icon: Icon(
            Icons.send,
          ),
        )
      ],
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.message, required this.id});
  final String id;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: id != 'bot'
          ? EdgeInsets.only(left: 20, bottom: 10, top: 10)
          : EdgeInsets.only(right: 20, bottom: 10, top: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: id == 'bot'
                ? Color.fromARGB(255, 216, 193, 126)
                : Color.fromARGB(255, 140, 153, 228)),
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.center,
            child: Text(id),
          ),
          Text(message),
        ]),
      ),
    );
  }
}
