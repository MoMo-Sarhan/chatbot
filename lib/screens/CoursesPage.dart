// ignore_for_file: prefer_const_constructors

import 'package:chatbot/component/CourseCard.dart';
import 'package:chatbot/component/setting_appbar.dart';
import 'package:chatbot/models/Course.dart';
import 'package:chatbot/screens/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  ScrollController _controller = ScrollController();
  bool _isAppBarVisible = true;
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
  void initState() {
    super.initState();
    _controller.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_controller.position.outOfRange) {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        // Scrolling down
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false;
          });
        }
      } else if (_controller.position.userScrollDirection ==
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
      appBar: _isAppBarVisible ? SettingAppBar(title: 'Courses') : null,
      body: _listViewBuild(),
    );
  }

  Widget _listViewBuild() {
    return ListView.builder(
        controller: _controller,
        itemCount: CoursesItem.length,
        itemBuilder: (context, index) => CoursesItem[index]);
  }
}
