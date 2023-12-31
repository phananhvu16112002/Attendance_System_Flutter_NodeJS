import 'package:attendance_system_nodejs/common/bases/CustomAppBar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomRichText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';

import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/DetailPage.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:attendance_system_nodejs/services/GetLocation.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
  String? address;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkLocationService();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        var studentDataProvider =
            Provider.of<StudentDataProvider>(context, listen: false);
        studentDataProvider.updateLocationData(
          studentDataProvider.userData.latitude,
          studentDataProvider.userData.longtitude,
          studentDataProvider.userData.location,
        );
      }
    });
  }

  void getAddress() {
    var studentDataProvider =
        Provider.of<StudentDataProvider>(context, listen: false);
    if (studentDataProvider.userData.latitude != 0.0 &&
        studentDataProvider.userData.longtitude != 0.0 &&
        studentDataProvider.userData.location.isNotEmpty) {
      studentDataProvider.updateLocationData(
        studentDataProvider.userData.latitude,
        studentDataProvider.userData.longtitude,
        studentDataProvider.userData.location,
      );
    }
  }

  Future<void> checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSettingsAlert();
    }
  }

  void showSettingsAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text('Please grant permission to get your location.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Đóng hộp thoại
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await Geolocator.openLocationSettings();
            },
            child: const Text(
              'Open Settings',
              style: TextStyle(color: AppColors.primaryButton),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classDataProvider =
        Provider.of<StudentClassesDataProvider>(context, listen: false);
    final provider = Provider.of<StudentDataProvider>(context);
    return SingleChildScrollView(
        //Column Tổng body
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          CustomAppBar(
            context: context,
            address: 'Address: ${provider.userData.location}',
          ),
          //Search Bar
          Positioned(
            top: 285,
            left: 25,
            right: 25,
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
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search class | Example: CourseID,..',
                )),
          ),
          //Body 2
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 350),
                  child: Row(
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
                ),
              ],
            ),
          )
        ]),
        if (!activeQR)
          Container(
            child: StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  print(snapshot.toString());
                  if (snapshot.hasData) {
                    ConnectivityResult? result = snapshot.data;
                    if (result == ConnectivityResult.wifi ||
                        result == ConnectivityResult.mobile) {
                      return FutureBuilder(
                        future: API().getStudentClass(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              List<StudentClasses> studentClasses =
                                  snapshot.data!;
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
                                                DetailPage(
                                              studentClasses: data,
                                            ),
                                            transitionDuration: const Duration(
                                                milliseconds: 200),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return ScaleTransition(
                                                scale: animation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: classInformation(
                                          data.classes.course.totalWeeks,
                                          data.classes.course.courseName,
                                          data.classes.teacher.teacherName,
                                          data.classes.course.courseID,
                                          data.classes.classType,
                                          data.classes.group,
                                          data.classes.subGroup,
                                          data.classes.shiftNumber,
                                          data.classes.roomNumber,
                                          true, // Chỉnh thành status Form
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return const Text('null');
                        },
                      );
                    } else {
                      return const Center(child: Text('No internet'));
                    }
                  }
                  return loading();
                }),
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
                          message: 'Scanning will be started automatically',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Stack(children: [
                  Container(
                    height: 400,
                    width: 400,
                    child: QRView(
                        overlay: QrScannerOverlayShape(
                          borderLength: 30,
                          borderColor: AppColors.primaryButton,
                          borderWidth: 10,
                          borderRadius: 10,
                        ),
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 160,
                    right: 160,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          maxLines: 3,
                          result != null ? '${result!.code}' : 'Scan QR Code',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
      ],
    ));
  }

  Widget loading() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.primaryButton),
    );
  }

  Widget classInformation(
      int totalWeeks,
      String courseName,
      String teacherName,
      String courseID,
      String classType,
      String group,
      String subGroup,
      int shift,
      String roomNumber,
      bool activeForm) {
    return Container(
        width: 410,
        height: 150,
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
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: SizedBox(
                  width: 55,
                  height: 80,
                  child: CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 5,
                    percent: 0.9, // Thay đổi giá trị tại đây
                    center: Text(
                      "$totalWeeks Weeks",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                    backgroundColor:
                        !activeForm ? AppColors.secondaryText : Colors.white,
                    progressColor: AppColors.primaryButton,
                    animation: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Container(
                width: 150,
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
                      title: 'Type: ',
                      message: '$classType',
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        customRichText(
                          title: 'Group: ',
                          message: "$group",
                          fontWeightTitle: FontWeight.bold,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 13,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        customRichText(
                          title: 'SubGroup: ',
                          message: '$subGroup',
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
                  height: 90,
                  width: 2,
                  color: Colors.black),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: !activeForm
                    ? const EdgeInsets.only(top: 20, bottom: 20)
                    : const EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customRichText(
                      title: 'Total Attendance: ',
                      message: '0',
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const customRichText(
                      title: 'Total Late: ',
                      message: '0',
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
                      message: '0',
                      fontWeightTitle: FontWeight.bold,
                      fontWeightMessage: FontWeight.w400,
                      colorText: AppColors.primaryText,
                      fontSize: 13,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 35, top: 10),
                    //   child: !activeForm
                    //       ? Container()
                    //       : CustomButton(
                    //           buttonName: 'Attendance',
                    //           colorShadow: Colors.transparent,
                    //           backgroundColorButton: AppColors.primaryButton,
                    //           borderColor: Colors.transparent,
                    //           textColor: Colors.white,
                    //           function: () {
                    //             Navigator.push(
                    //               context,
                    //               PageRouteBuilder(
                    //                 pageBuilder: (context, animation,
                    //                         secondaryAnimation) =>
                    //                     const AttendanceFormPage(),
                    //                 transitionDuration:
                    //                     const Duration(milliseconds: 300),
                    //                 transitionsBuilder: (context, animation,
                    //                     secondaryAnimation, child) {
                    //                   return ScaleTransition(
                    //                     scale: animation,
                    //                     child: child,
                    //                   );
                    //                 },
                    //               ),
                    //             );
                    //           },
                    //           height: 30,
                    //           width: 90,
                    //           fontSize: 13),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
