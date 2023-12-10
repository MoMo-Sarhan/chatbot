// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/Course.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key, required this.course});
  final Course course;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  int getProgress(Course item) {
    double temp = item.progress * 200;

    return temp.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: SettingAppBar(title: widget.course.courseName),
              );
            }),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Color.fromARGB(255, 250, getProgress(widget.course), 0),
          margin: EdgeInsets.all(3.0),
          child: ListTile(
            title: Text(widget.course.courseName),
            subtitle: LinearProgressIndicator(
              value: widget.course.progress,
              minHeight: 10.0,
            ),
            trailing: Text('${(widget.course.progress * 100)}'),
          ),
        ));
  }
}
