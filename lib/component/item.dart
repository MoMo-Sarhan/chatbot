// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  Item({
    super.key,
    required this.icon_1,
    required this.text,
    required this.icon_2,
    required this.onpressed,
  });
  IconData icon_1;
  IconData icon_2;
  String text;
  Function() onpressed;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(children: [
            Spacer(
              flex: 1,
            ),
            Icon(
              this.widget.icon_1,
            ),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              width: 100,
              child: Text(
                this.widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            IconButton(
              onPressed: this.widget.onpressed,
              icon: Icon(
                this.widget.icon_2,
              ),
            ),
          ]),
        ),
        Divider(
          color: Colors.amber,
          indent: 75,
          endIndent: 75,
        )
      ],
    );
  }
}
