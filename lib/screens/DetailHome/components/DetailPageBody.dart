import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/providers/attendanceDetail_data_provider.dart';
import 'package:attendance_system_nodejs/providers/attendanceForm_data_provider.dart';
import 'package:attendance_system_nodejs/providers/socketServer_data_provider.dart';
import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/ReportAttendance.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailPageBody extends StatefulWidget {
  const DetailPageBody({super.key, required this.studentClasses});
  final StudentClasses studentClasses;

  @override
  State<DetailPageBody> createState() => _DetailPageBodyState();
}

class _DetailPageBodyState extends State<DetailPageBody> {
  bool activeTotal = true;
  bool activePresent = false;
  bool activeAbsent = false;
  bool activeLate = false;
  late StudentClasses studentClasses;
  int totalPresence = 0;
  int totalAbsence = 0;
  int totalLate = 0;
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentClasses = widget.studentClasses;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceDetailDataProvider =
        Provider.of<AttendanceDetailDataProvider>(context, listen: false);
    final studentClassesDataProvider =
        Provider.of<StudentClassesDataProvider>(context, listen: false);
    StudentClasses? dataStudentClasses = studentClassesDataProvider
        .getDataForClass(widget.studentClasses.classes.classID);
    final attendanceFormDataProvider =
        Provider.of<AttendanceFormDataProvider>(context, listen: false);
    final socketServerDataProvider =
        Provider.of<SocketServerProvider>(context, listen: false);
    final studentDataProvider =
        Provider.of<StudentDataProvider>(context, listen: false);
    return FutureBuilder(
      future: API().getAttendanceDetail(studentClasses.classes.classID,
          studentDataProvider.userData.studentID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                customLoading(),
                const SizedBox(
                  height: 10,
                ),
                customLoading(),
                const SizedBox(
                  height: 10,
                ),
                customLoading()
              ],
            ),
          ));
        } else if (snapshot.hasError) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.cardAttendance,
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            List<AttendanceDetail> attendanceDetail = snapshot.data!;
            Future.delayed(Duration.zero, () {
              attendanceDetailDataProvider
                  .setAttendanceDetailList(attendanceDetail);
            });
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.cardAttendance,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.secondaryText,
                                blurRadius: 5.0,
                                offset: Offset(0.0, 0.0))
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeAbsent = false;
                                activeLate = false;
                                activePresent = false;
                                activeTotal = true;
                              });
                            },
                            child: Container(
                              width: 95,
                              decoration: BoxDecoration(
                                  color: activeTotal
                                      ? AppColors.cardAttendance
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: CustomText(
                                    message:
                                        'Total: ${dataStudentClasses!.total.ceil()}',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeAbsent = false;
                                activeLate = false;
                                activePresent = true;
                                activeTotal = false;
                              });
                            },
                            child: Container(
                              width: 95,
                              decoration: BoxDecoration(
                                  color: activePresent
                                      ? const Color.fromARGB(94, 137, 210, 64)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: CustomText(
                                    message:
                                        'Present: ${dataStudentClasses.totalPresence.ceil()}',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeAbsent = true;
                                activeLate = false;
                                activePresent = false;
                                activeTotal = false;
                              });
                            },
                            child: Container(
                              width: 95,
                              decoration: BoxDecoration(
                                  color: activeAbsent
                                      ? const Color.fromARGB(216, 219, 87, 87)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: CustomText(
                                    message:
                                        'Absent: ${dataStudentClasses.totalAbsence.ceil()}',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                activeAbsent = false;
                                activeLate = true;
                                activePresent = false;
                                activeTotal = false;
                              });
                            },
                            child: Container(
                              width: 95,
                              decoration: BoxDecoration(
                                  color: activeLate
                                      ? const Color.fromARGB(231, 232, 156, 63)
                                      : Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                child: CustomText(
                                    message:
                                        'Late: ${dataStudentClasses.totalLate.ceil()}',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream:
                                socketServerDataProvider.attendanceFormStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  AttendanceForm? data = snapshot.data;
                                  Future.delayed(Duration.zero, () {
                                    attendanceFormDataProvider
                                        .setAttendanceFormData(data!);
                                  });
                                  return customCard(
                                      formatTime(data!.startTime),
                                      formatTime(data.endTime),
                                      formatDate(data.dateOpen),
                                      '',
                                      getResult(0),
                                      '',
                                      '',
                                      data.status,
                                      data);
                                } else {
                                  return const Text('Data is null');
                                }
                              } else if (snapshot.hasError) {
                                return Text('Error:${snapshot.error}');
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            itemCount: attendanceDetail.length,
                            shrinkWrap: true,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              var data = attendanceDetail[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 10, right: 10),
                                child: customCard(
                                    formatTime(data.attendanceForm.startTime),
                                    formatTime(data.attendanceForm.endTime),
                                    data.dateAttendanced != ''
                                        ? formatDate(
                                            data.dateAttendanced.toString())
                                        : formatDate(
                                            data.attendanceForm.dateOpen),
                                    data.dateAttendanced != ''
                                        ? formatTime(data.dateAttendanced)
                                        : 'null',
                                    getResult(data.result),
                                    data.dateAttendanced != ''
                                        ? data.location
                                        : 'null',
                                    data.url,
                                    data.attendanceForm.status,
                                    data.attendanceForm),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Text('Data Not Avalible');
      },
    );
  }

  Container customCard(
      String startTime,
      String endTime,
      String date,
      String timeAttendance,
      String status,
      String location,
      String url,
      bool statusForm,
      AttendanceForm attendanceForm) {
    return Container(
      width: 405,
      height: 240,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(195, 190, 188, 188),
                blurRadius: 5.0,
                offset: Offset(2.0, 1.0))
          ]),
      child: Column(
        children: [
          CustomText(
              message: date.toString(),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText),
          const SizedBox(
            height: 2,
          ),
          Container(
            height: 1,
            width: 405,
            color: const Color.fromARGB(105, 190, 188, 188),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Container(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRichText(
                          'Start Time: ',
                          startTime,
                          FontWeight.w600,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'End Time: ',
                          endTime,
                          FontWeight.w600,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Location: ',
                          location,
                          FontWeight.w600,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Time Attendance: ',
                          timeAttendance.toString(),
                          FontWeight.w600,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Status: ',
                          status,
                          FontWeight.w600,
                          FontWeight.w500,
                          AppColors.primaryText,
                          getColorBasedOnStatus(status)),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                height: 130,
                width: 130,
                child: url.isEmpty || url == ''
                    ? Image.asset('assets/images/logo.png')
                    : Image.network(url),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 1,
            width: 405,
            color: const Color.fromARGB(105, 190, 188, 188),
          ),
          const SizedBox(
            height: 8,
          ),
          if (statusForm)
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AttendanceFormPage(
                            // attendanceForm: attendanceForm,
                            ),
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var curve = Curves.easeInOutCubic;
                      var tween =
                          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                              .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const CustomText(
                  message: 'Take Attendance',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryButton),
            )
          else
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ReportAttendance(),
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var curve = Curves.easeInOutCubic;
                      var tween =
                          Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                              .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const CustomText(
                  message: 'Report',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.importantText),
            )
        ],
      ),
    );
  }

  RichText customRichText(
      String title,
      String message,
      FontWeight fontWeightTitle,
      FontWeight fontWeightMessage,
      Color colorTextTitle,
      Color colorTextMessage) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: title,
        style: TextStyle(
          fontWeight: fontWeightTitle,
          fontSize: 15,
          color: colorTextTitle,
        ),
      ),
      TextSpan(
        text: message,
        style: TextStyle(
          fontWeight: fontWeightMessage,
          fontSize: 15,
          color: colorTextMessage,
        ),
      ),
    ]));
  }

  Color getColorBasedOnStatus(String status) {
    if (status.contains('Present')) {
      return AppColors.textApproved;
    } else if (status.contains('Late')) {
      return const Color.fromARGB(231, 196, 123, 34);
    } else if (status.contains('Absence')) {
      return AppColors.importantText;
    } else {
      return AppColors.primaryText;
    }
  }

  String getResult(double result) {
    if (result.ceil() == 1) {
      return 'Present';
    } else if (result == 0.5) {
      return 'Late';
    } else if (result.ceil() == 0) {
      return 'Absence';
    } else {
      return 'Absence';
    }
  }

  String formatDate(String date) {
    DateTime serverDateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
    return formattedDate;
  }

  String formatTime(String time) {
    DateTime serverDateTime = DateTime.parse(time).toLocal();
    String formattedTime = DateFormat("HH:mm:ss a").format(serverDateTime);
    return formattedTime;
  }

  Widget customLoading() {
    return Container(
      width: 405,
      height: 220,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(195, 190, 188, 188),
                blurRadius: 5.0,
                offset: Offset(2.0, 1.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Shimmer.fromColors(
                baseColor: const Color.fromARGB(78, 158, 158, 158),
                highlightColor: const Color.fromARGB(146, 255, 255, 255),
                child: Container(width: 300, height: 10, color: Colors.white)),
            const SizedBox(
              height: 2,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 30,
                                    height: 10,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 2,
                            ),
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 110,
                                    height: 10,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 30,
                                    height: 10,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 2,
                            ),
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 110,
                                    height: 10,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 50,
                                    height: 10,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 2,
                            ),
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 150,
                                    height: 10,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 40,
                                    height: 10,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 2,
                            ),
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 175,
                                    height: 10,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 50,
                                    height: 10,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 2,
                            ),
                            Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(78, 158, 158, 158),
                                highlightColor:
                                    const Color.fromARGB(146, 255, 255, 255),
                                child: Container(
                                    width: 170,
                                    height: 10,
                                    color: Colors.white)),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Shimmer.fromColors(
                    baseColor: const Color.fromARGB(78, 158, 158, 158),
                    highlightColor: const Color.fromARGB(146, 255, 255, 255),
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              width: 405,
              color: const Color.fromARGB(105, 190, 188, 188),
            ),
            const SizedBox(
              height: 20,
            ),
            Shimmer.fromColors(
                baseColor: const Color.fromARGB(78, 158, 158, 158),
                highlightColor: const Color.fromARGB(146, 255, 255, 255),
                child: Container(width: 100, height: 10, color: Colors.white))
          ],
        ),
      ),
    );
  }
}








// return StreamBuilder(
//                 stream: socketServerDataProvider.attendanceFormStream,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     if (snapshot.data != null) {
//                       return Text('Data: ${snapshot.data!.dateOpen}');
//                     } else {
//                       return Text('Error:${snapshot.error}');
//                     }
//                   } else {
//                     return Text('---Error');
//                   }
//                 });

