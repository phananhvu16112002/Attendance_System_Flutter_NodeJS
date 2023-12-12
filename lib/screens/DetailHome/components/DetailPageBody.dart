import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/providers/attendanceDetail_data_provider.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentClasses = widget.studentClasses;
  }

  @override
  Widget build(BuildContext context) {
    final attendanceDetailDataProvider =
        Provider.of<AttendanceDetailDataProvider>(context, listen: false);

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
              height: 50,
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: activeTotal
                              ? AppColors.cardAttendance
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: CustomText(
                            message: 'Total: 10',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: activePresent
                              ? const Color.fromARGB(94, 137, 210, 64)
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: CustomText(
                            message: 'Present: 5',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: activeAbsent
                              ? const Color.fromARGB(216, 219, 87, 87)
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: CustomText(
                            message: 'Absent: 3',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: activeLate
                              ? const Color.fromARGB(231, 232, 156, 63)
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: CustomText(
                            message: 'Late: 2',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FutureBuilder(
                future:
                    API().getAttendanceDetail(studentClasses.classes.classID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<AttendanceDetail> attendanceDetail = snapshot.data!;
                      // Cập nhật dữ liệu vào Provider
                      Future.delayed(Duration.zero, () {
                        attendanceDetailDataProvider
                            .setAttendanceDetailList(attendanceDetail);
                      });
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: attendanceDetail.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = attendanceDetail[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: customCard(
                                  formatDate(data.dateAttendanced.toString()),
                                  formatTime(data.dateAttendanced.toString()),
                                  getStatusText(
                                      data.present, data.late, data.absence),
                                  data.location),
                            );
                          });
                    }
                  }
                  return const Text('Data is not available');
                })
          ],
        ),
      ),
    );
  }

  Container customCard(
      String date, String timeAttendance, String status, String location) {
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
      child: Column(
        children: [
          CustomText(
              message: date.toString(),
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                child: Container(
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRichText(
                          'Location: ',
                          location,
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Time Attendance: ',
                          timeAttendance.toString(),
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Status: ',
                          status,
                          FontWeight.bold,
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
                height: 140,
                width: 140,
                child: Image.asset('assets/images/logo.png'),
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
            height: 5,
          ),
          const CustomText(
              message: 'Report',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryButton)
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
    if (status.contains('Successfully')) {
      return AppColors.textApproved;
    } else if (status.contains('Late')) {
      return const Color.fromARGB(231, 196, 123, 34);
    } else if (status.contains('Absent')) {
      return AppColors.importantText;
    } else {
      return AppColors.primaryText;
    }
  }

  String getStatusText(bool present, bool late, bool absence) {
    if (present) {
      return 'Successfully';
    } else if (late) {
      return 'Late';
    } else if (absence) {
      return 'Absent';
    } else {
      // Nếu cả ba giá trị đều là false, trả về chuỗi "Absent"
      return 'Absent';
    }
  }

  String formatDate(String date) {
    DateTime serverDateTime = DateTime.parse(date);
    String formattedDate = DateFormat('MMMM d, y').format(serverDateTime);
    return formattedDate;
  }

  String formatTime(String time) {
    DateTime serverDateTime = DateTime.parse(time);
    String formattedTime = DateFormat('HH:mm:ss').format(serverDateTime);
    return formattedTime;
  }
}
