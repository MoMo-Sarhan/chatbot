// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/services/chooseIcon_service.dart';
import 'package:flutter/material.dart';

class ChangeIconPage extends StatefulWidget {
  const ChangeIconPage({super.key});

  @override
  State<ChangeIconPage> createState() => _ChangeIconPageState();
}

class _ChangeIconPageState extends State<ChangeIconPage> {
  ChooseIcon _chooseIcon = ChooseIcon();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingAppBar(title: 'Change Icon'),
        body: Stack(
          children: [
            FutureBuilder(
              future: _chooseIcon.getUserImageUrl(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(snapshot.data!),
                    ),
                  );
                } else {
                  return Center(child: Icon(Icons.person));
                }
              }),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2 + 60,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _chooseIcon.chooseImage();
                      });
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.blue,
                    )))
          ],
        )

        // Column(
        //   children: [
        //     CircleAvatar(
        //         child: Image(
        //             image:
        //                 NetworkImage(_chooseIcon.getUserImageUrl().toString()))),
        //     Center(
        //       child: IconButton(
        //           onPressed: _chooseIcon.chooseImage,
        //           icon: Icon(Icons.add_a_photo)),
        //     ),
        //   ],
        // ),
        );
  }
}
