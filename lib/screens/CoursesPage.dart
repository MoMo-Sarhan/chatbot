// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/CourseCard.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/Course.dart';
import 'package:chatbot/screens/settingsPage.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  ScrollController controller = ScrollController();
  List<CourseCard> CoursesItem = [
    CourseCard(course: Course(courseName: 'Machine Learning', progress: .20)),
    CourseCard(course: Course(courseName: 'Computer Since', progress: 1.0)),
    CourseCard(course: Course(courseName: 'Image Processing', progress: 1.0)),
    CourseCard(
        course: Course(courseName: 'Computer Architicture', progress: .30)),
    CourseCard(course: Course(courseName: 'Assembly', progress: .50)),
    CourseCard(course: Course(courseName: 'Mobile Application', progress: .70)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .0)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Computer Vision', progress: .40)),
    CourseCard(course: Course(courseName: 'Compiler', progress: .0))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingAppBar(title: 'Courses'),
      body: _listViewBuild(),
    );
  }

  Widget _listViewBuild() {
    return ListView.builder(
        itemCount: CoursesItem.length,
        itemBuilder: (context, index) => CoursesItem[index]);
  }
}
