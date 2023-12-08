// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/setting_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6229e8),
      appBar: SettingAppBar(title: 'Rating The App'),
      body: Center(
          child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          RatingBar.builder(
              initialRating: rate,
              allowHalfRating: true,
              direction: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (value) {
                setState(() {
                  rate = value;
                });
              }),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '${rate}',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Submit')),
          Spacer(
            flex: 3,
          ),
        ],
      )),
    );
  }
}
