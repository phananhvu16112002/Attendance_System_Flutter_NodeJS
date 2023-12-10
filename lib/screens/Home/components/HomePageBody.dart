import 'package:attendance_system_nodejs/common/bases/CustomAppBar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomRichText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/DetailPage.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceForm.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  TextEditingController searchController = TextEditingController();
  bool activeQR = false;
  bool activeForm = false;
  Barcode? result;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // ignore: avoid_print
      print('Scanned Data: $scanData');
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classDataProvider =
        Provider.of<StudentClassesDataProvider>(context, listen: false);
    return SingleChildScrollView(
        //Column Tổng body
        child: Column(
      children: [
        Stack(children: [
          CustomAppBar(context: context),
          //Search Bar
          Positioned(
            top: 285,
            left: 25,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.secondaryText,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.0))
                    ]),
                //Fix PrefixIcon
                child: CustomTextField(
                  readOnly: false,
                  controller: searchController,
                  textInputType: TextInputType.text,
                  obscureText: false,
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(null)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search class | Example: CourseID,..',
                )),
          ),

          //Body 2

          Container(
            color: AppColors.cardAttendance,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 350),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activeQR = false;
                        });
                      },
                      child: Container(
                        width: 142,
                        height: 30,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: activeQR
                                ? Colors.white
                                : AppColors.primaryButton,
                            border: Border.all(
                                color: AppColors.secondaryText, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: CustomText(
                                message: 'Take Attendance',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: activeQR
                                    ? AppColors.primaryText
                                    : Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activeQR = true;
                        });
                      },
                      child: Container(
                        width: 142,
                        height: 26,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: activeQR
                                ? AppColors.primaryButton
                                : Colors.white,
                            border: Border.all(
                                color: AppColors.secondaryText, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: CustomText(
                                message: 'Scan QR',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: activeQR
                                    ? Colors.white
                                    : AppColors.primaryText)),
                      ),
                    )
                  ],
                ),
                if (!activeQR)
                  FutureBuilder(
                    future: API().getStudentClass(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          List<StudentClasses> studentClasses = snapshot.data!;
                          // Cập nhật dữ liệu vào Provider
                          Future.delayed(Duration.zero, () {
                            classDataProvider
                                .setStudentClassesList(studentClasses);
                          });
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: studentClasses.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = studentClasses[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const DetailPage(),
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return ScaleTransition(
                                            scale: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: classInformation(
                                    data.classes.course.totalWeeks,
                                    data.classes.course.courseName,
                                    data.classes.teacher.teacherName,
                                    data.classes.course.courseID,
                                    data.classes.shiftNumber,
                                    data.classes.roomNumber,
                                    data.presenceTotal,
                                    data.lateTotal,
                                    data.absenceTotal,
                                    true, // Chỉnh thành status Form
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                      return const Text('null');
                    },
                  )
                else
                  Container(
                    height: 500,
                    child: Column(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  message: 'SCAN QR CODE',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText),
                              CustomText(
                                  message:
                                      'Scanning will be started automatically',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryText),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 400,
                          width: 400,
                          color: Colors.black,
                          // child: QRView(
                          //     key: qrKey, onQRViewCreated: _onQRViewCreated),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ]),
      ],
    ));
  }

  Container classInformation(
      int totalWeeks,
      String courseName,
      String teacherName,
      String courseID,
      int shift,
      String roomNumber,
      int presenceTotal,
      int lateTotal,
      int absenceTotal,
      bool activeForm) {
    return Container(
        width: 405,
        height: 120,
        decoration: BoxDecoration(
            color: !activeForm ? Colors.white : AppColors.cardHome,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 5.0,
                  offset: Offset(3.0, 2.0))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 55,
                  height: 80,
                  child: CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 5,
                    percent: 0.5, // Thay đổi giá trị tại đây
                    center: Text(
                      "$totalWeeks Weeks",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    backgroundColor:
                        !activeForm ? AppColors.secondaryText : Colors.white,
                    progressColor:
                        !activeForm ? AppColors.primaryButton : Colors.green,
                    animation: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Container(
                width: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customRichText(
                      title: 'Course: ',
                      message: courseName,
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText(
                      title: 'Lectuer: ',
                      message: teacherName,
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText(
                      title: 'CourseID: ',
                      message: courseID,
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        customRichText(
                          title: 'Shift: ',
                          message: "$shift",
                          fontWeightTitle: FontWeight.bold,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 13,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        customRichText(
                          title: 'Class: ',
                          message: roomNumber,
                          fontWeightTitle: FontWeight.bold,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  height: 75,
                  width: 2,
                  color: const Color.fromARGB(96, 190, 188, 188)),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding:
                    !activeForm ? EdgeInsets.only(top: 20) : EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customRichText(
                      title: 'Total Attendance: ',
                      message: '$presenceTotal',
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText(
                      title: 'Total Late: ',
                      message: '$lateTotal',
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText(
                      title: 'Total Absent: ',
                      message: '$absenceTotal',
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: !activeForm
                          ? Container()
                          : CustomButton(
                              buttonName: 'Attendance',
                              colorShadow: Colors.transparent,
                              backgroundColorButton: !activeForm
                                  ? AppColors.primaryButton
                                  : Colors.green,
                              borderColor: Colors.transparent,
                              textColor: Colors.white,
                              function: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const AttendanceForm(),
                                    transitionDuration:
                                        const Duration(milliseconds: 300),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              height: 30,
                              width: 90,
                              fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
