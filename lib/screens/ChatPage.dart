// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/MessageContainer.dart';
import 'package:chatbot/component/my_text_filed.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/services/chat_services.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _listViewController = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ChatServices _chatServices = ChatServices();
  TextEditingController _messageConroller = TextEditingController();
  User? currentUSer;
  bool _isAppBarVisible = true;
  String? reciverId;
  String? pageTitle;
  ChooseIcon _chooseIcon = ChooseIcon();

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(_handleScroll);
    currentUSer = _firebaseAuth.currentUser;
    reciverId = _firebaseAuth.currentUser!.uid;
    pageTitle = currentUSer!.email.toString().split('@')[0];
  }

  @override
  void dispose() {
    _listViewController.removeListener(_handleScroll);
    super.dispose();
  }

  void _handleScroll() {
    if (!_listViewController.position.outOfRange) {
      if (_listViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scrolling down
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      } else if (_listViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // Scrolling up
        if (!_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: _isAppBarVisible ? SettingAppBar(title: pageTitle!) : null,
      drawer: Drawer(
        child: _buildUserList(),
        backgroundColor: Color(0xff6229e8),
      ),
      body: Column(children: [
        Expanded(
          child: _buildListMessage(),
        ),
        _inputTextField()
      ]),
    );
  }

  void SendMessage() async {
    print('listview ${_listViewController.hasClients}');
    setState(() {
      if (_messageConroller.text.isNotEmpty) {
        _chatServices.sendMessage(reciverId!, _messageConroller.text);
        _messageConroller.clear();
      }
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _listViewController.animateTo(
      //       _listViewController.position.maxScrollExtent,
      //       curve: Curves.easeOut,
      //       duration: Duration(milliseconds: 300));
      // });
    });
  }

  Widget _buildListMessage() {
    return StreamBuilder(
        stream: _chatServices.getMessage(reciverId!, currentUSer!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error.toString()}'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<DocumentSnapshot> messages = snapshot.data!.docs;
          return ListView(
            controller: _listViewController,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );

          // ListView.builder(
          //     controller: _listViewController,
          //     itemCount: messages.length,
          //     itemBuilder: (context, index) {
          //       return _buildMessageItem(messages[index]);
          //     });
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid);
    return MessageContainer(
      message: data['message'],
      id: data['senderEmail'].toString().split('@')[0],
      time: data['timestamp'],
      alignment: alignment,
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

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot docs) {
    Map<String, dynamic> data = docs.data()! as Map<String, dynamic>;
    if (_firebaseAuth.currentUser!.email != data['email']) {
      return ListTile(
        leading: CircleAvatar(
            child: FutureBuilder(
          future: _chooseIcon.getImageByUid(uid: data['uid']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              return CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data!),
              );
            } else {
              return Icon(Icons.person);
            }
          },
        )),
        title: Text(
          data['userName'] ?? '',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          setState(() {
            pageTitle = data['userName'].toString();

            reciverId = data['uid'];
          });
        },
      );
    } else {
      return ListTile(
        leading: CircleAvatar(
          child: FutureBuilder(
            future: _chooseIcon.getUserImageUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data!),
                );
              } else {
                return Icon(Icons.person);
              }
            },
          ),
        ),
        title: Text(
          data['userName'],
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          setState(() {
            pageTitle = data['userName'].toString();
            reciverId = data['uid'];
          });
        },
      );
    }
  }
}
