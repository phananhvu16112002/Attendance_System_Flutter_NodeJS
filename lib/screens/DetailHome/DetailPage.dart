import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/Classroom.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/components/DetailPageBody.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/NotificationClass.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/ReportClass.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.studentClasses,
  });
  final StudentClasses studentClasses;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _bottomNavIndex = 0;
  final List<IconData> _iconList = [
    Icons.newspaper,
    Icons.mail_outline,
    Icons.notifications_none_outlined,
    Icons.people
  ];
  late StudentClasses studentClasses;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentClasses = widget.studentClasses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.importantText,
          foregroundColor: Colors.white,
          elevation: 2,
          onPressed: () {},
          child: const Icon(
            Icons.report,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: _iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            activeColor: AppColors.primaryButton,
            iconSize: 25,
            backgroundColor: Colors.white,
            onTap: onTapHandler),
        appBar: customAppbar(),
        body: _buildBody());
  }

  PreferredSize customAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.arrow_back,
                color: Colors.white), // Thay đổi icon và màu sắc tùy ý
          ),
        ),
        backgroundColor: AppColors.colorAppbar,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 35, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  message: studentClasses.classes.course.courseName,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              Row(
                children: [
                  CustomText(
                      message:
                          'CourseID: ${studentClasses.classes.course.courseID}',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(height: 10, width: 1, color: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                      message: 'Room: ${studentClasses.classes.roomNumber}',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(height: 10, width: 1, color: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomText(
                      message: 'Shift: ${studentClasses.classes.shiftNumber}',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                  message:
                      'Lectuer: ${studentClasses.classes.teacher.teacherName}',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_bottomNavIndex) {
      case 0:
        return DetailPageBody(
          studentClasses: widget.studentClasses,
        );
      case 1:
        return const ReportClass();
      case 2:
        return const NotificationClass();
      case 3:
        return const Classroom();
      default:
        return DetailPageBody(
          studentClasses: widget.studentClasses,
        );
    }
  }

  void onTapHandler(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }
}
