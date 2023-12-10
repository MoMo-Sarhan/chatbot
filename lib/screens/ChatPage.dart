// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/MessageContainer.dart';
import 'package:chatbot/component/delay.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _listViewController = ScrollController();
  TextEditingController _messageConroller = TextEditingController();
  List<MessageContainer> MessagesItem = [
    MessageContainer(message: 'Welcome', id: 'bot')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      //TODO - disapper when scroll
      appBar: SettingAppBar(title: 'Chat Bot'),
      body: Column(children: [
        Expanded(
          child: _buildlistView(),
        ),
        _inputTextField()
      ]),
    );
  }

  void SendMessage() {
    setState(() {
      if (_messageConroller.text.isNotEmpty) {
        MessagesItem.add(
            MessageContainer(message: _messageConroller.text, id: 'User'));
        _messageConroller.clear();
        MyDelayFun(duration: Duration(seconds: 20));
        MessagesItem.add(
            MessageContainer(message: 'not Have Answer yet', id: 'bot'));
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _listViewController.animateTo(
            _listViewController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 3));
      });
    });
  }

  Widget _buildlistView() {
    return ListView.builder(
      itemCount: MessagesItem.length,
      itemBuilder: ((context, index) => MessagesItem[index]),
      controller: _listViewController,
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
}