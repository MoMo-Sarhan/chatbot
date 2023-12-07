import 'package:chatbot/models/icons.dart';
import 'package:flutter/material.dart';

class HomePageIcons extends StatelessWidget {
  HomePageIcons({ required this.myicon});
  icon? myicon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              iconSize: 50,
              icon: Icon(
                myicon?.ImageIcon,
                color: Colors.black,
              ),
              onPressed:myicon?.onPressed,
            ),
            Text('${myicon?.descript}'),
          ],
        )
      ],
    );
  }
}
