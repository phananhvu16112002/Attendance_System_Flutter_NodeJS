import 'dart:async';
import 'dart:convert';
import 'package:attendance_system_nodejs/common/bases/CustomAppBar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomRichText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:attendance_system_nodejs/models/ClassesStudent.dart';
import 'package:attendance_system_nodejs/models/DataOffline.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/providers/classesStudent_data_provider.dart';
import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/DetailPage.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/DetailPageOffline.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPageOffline.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPageQR.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:attendance_system_nodejs/services/GetLocation.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shimmer/shimmer.dart';

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
  final SecureStorage secureStorage = SecureStorage();
  late Box<DataOffline> dataOfflineBox;
  late Box<StudentClasses> studentClassesBox;
  late Box<ClassesStudent> classesStudentBox;
  bool scanningQR = false;
  bool isConnected = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    studentClassesBox = Hive.box<StudentClasses>('student_classes');
    dataOfflineBox = Hive.box<DataOffline>('DataOfflineBoxes');
    classesStudentBox = Hive.box<ClassesStudent>('classes_student_box');
    // checkLocationService();
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
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (mounted) {
        setState(() {
          isConnected = result != ConnectivityResult.none;
          if (isConnected) {
            sendDataToServer();
          } else {
            print('no internet');
          }
        });
      }
    });
  }

  void sendDataToServer() async {
    DataOffline? dataOffline = dataOfflineBox.get('dataOffline');
    String xFile = await SecureStorage().readSecureData('imageOffline');
    if (xFile.isNotEmpty && xFile != 'No Data Found' && dataOffline != null) {
      String? location = await GetLocation()
          .getAddressFromLatLongWithoutInternet(
              dataOffline.latitude, dataOffline.longitude);
      print('location: $location');
      bool check = await API(context).takeAttendanceOffline(
          dataOffline.studentID,
          dataOffline.classID,
          dataOffline.formID,
          dataOffline.dateAttendanced,
          location ?? '',
          dataOffline.latitude,
          dataOffline.longitude,
          XFile(xFile));
      if (check) {
        print('Successfully take attendance offline');
        await dataOfflineBox.delete('dataOffline');
        if (dataOfflineBox.isEmpty) {
          print('Delete ok');
        } else {
          print('No ok');
        }
      } else {
        print('Failed take attendance offline');
      }
    } else {
      print('Data is not available');
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (mounted) {
        setState(() {
          result = scanData;
        });
        if (result != null &&
            result!.code != null &&
            result!.code!.isNotEmpty) {
          print('-------------Result:${result!.code}');
          print(
              'JSON: ${jsonDecode(result!.code.toString())}'); // modify and get value here.
          var temp = jsonDecode(result!.code.toString());
          if (isConnected) {
            // check connection(internet)
            print('isConnected QR: $isConnected');
            if (temp['typeAttendanced'] == 0 || temp['typeAttendanced'] == 1) {
              controller.pauseCamera();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AttendanceFormPageQR(
                          attendanceForm: AttendanceForm(
                              formID: temp['formID'],
                              classes: temp['classID'],
                              startTime: temp['startTime'],
                              endTime: temp['endTime'],
                              dateOpen: temp['dateOpen'],
                              status: false,
                              typeAttendance: temp['typeAttendanced'],
                              location: '',
                              latitude: 0.0,
                              longtitude: 0.0,
                              radius: 0.0),
                        )),
              );

              //Send request(formid, classID, dateAttendanced, studentID, location, latitude, longitude)
            } else {
              print('Send Request---------');
            }
          } else {
            print('isConnected offline: $isConnected');

            controller.pauseCamera();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AttendanceFormPageOffline(
                        attendanceForm: AttendanceForm(
                            formID: temp['formID'],
                            classes: temp['classID'],
                            startTime: temp['startTime'],
                            endTime: temp['endTime'],
                            dateOpen: temp['dateOpen'],
                            status: false,
                            typeAttendance:
                                0, //0 vì không có mạng mặc định là quét mặt
                            location: '',
                            latitude: 0.0,
                            longtitude: 0.0,
                            radius: 0.0),
                      )),
            );
          }
        } else {
          print('Data is not available');
        }
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

  //--Hive--
  // Future<void> openDataOfflineBox() async {
  //   await Hive.initFlutter();
  //   if (!Hive.isBoxOpen('DataOfflineBoxes')) {
  //     dataOfflineBox = await Hive.openBox<DataOffline>('DataOfflineBoxes');
  //     print('Successfully opened DataOfflineBoxes');
  //   } else {
  //     dataOfflineBox = Hive.box<DataOffline>('DataOfflineBoxes');
  //     print('DataOfflineBoxes is already open');
  //   }
  // }
  // Future<void> openBox() async {
  //   await Hive.initFlutter();
  //   if (!Hive.isBoxOpen('student_classes')) {
  //     studentClassesBox = await Hive.openBox<StudentClasses>('student_classes');
  //     print('Successfully opened student_classes');
  //   } else {
  //     studentClassesBox = Hive.box<StudentClasses>('student_classes');
  //     print('student_classes is already open');
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  // void saveListStudentClasses(List<StudentClasses> listData) async {
  //   if (studentClassesBox!.isOpen) {
  //     for (var temp in listData) {
  //       await studentClassesBox!.put(temp.classes.classID, temp);
  //     }
  //     print('Successfully Save List StudentClasses');
  //   } else {
  //     print('Box is not open');
  //   }
  // }

  void saveListClassesStudent(List<ClassesStudent> listData) async {
    if (classesStudentBox.isOpen) {
      for (var temp in listData) {
        await classesStudentBox.put(temp.classID, temp);
      }
      print('Successfully Save List ClassesStudent');
    } else {
      print('Box is not open');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final classDataProvider =
    //     Provider.of<StudentClassesDataProvider>(context, listen: false);
    final studentDataProvider = Provider.of<StudentDataProvider>(context);
    final classesStudentDataProvider =
        Provider.of<ClassesStudentProvider>(context, listen: false);
    print('Size Width: ${MediaQuery.of(context).size.width}');
    print('Size Height: ${MediaQuery.of(context).size.height}');

    return SingleChildScrollView(
        // controller: _controller,
        //Column Tổng body
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          CustomAppBar(
            context: context,
            address: 'Address: ${studentDataProvider.userData.location}',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 350),
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
                      print('----------------------------asdsadsad');
                      return callAPI(context, classesStudentDataProvider);
                    } else if (result == ConnectivityResult.none ||
                        isConnected == false) {
                      print(
                          '----------------------------asdsadasdasdsadasdassad');

                      return noInternetWithHive();
                    }
                  }
                  // print('before StreamBuilder:$isConnected');
                  // return snapshot.data callAPI(context, classDataProvider);
                  // return snapshot.data == ConnectivityResult.mobile ||
                  //         snapshot.data == ConnectivityResult.wifi
                  //     ? callAPI(context, classDataProvider)
                  //     : noInternetWithHive();
                  if (isConnected) {
                    // Sử dụng isConnected để kiểm tra kết nối mạng
                    return callAPI(context, classesStudentDataProvider);
                  } else {
                    return noInternetWithHive();
                  }
                }),
          )
        else
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(),
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
                    SizedBox(
                      height: 400,
                      width: 500,
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
                        width: 60,
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
          ),
      ],
    ));
  }

  FutureBuilder<List<ClassesStudent>> callAPI(
      BuildContext context, ClassesStudentProvider classDataProvider) {
    return FutureBuilder(
      future: API(context).getClassesStudent(), //Chinh parameter
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
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
                  customLoading(),
                ],
              ));
        } else if (snapshot.hasError) {
          print('Error');
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          if (snapshot.data == [] ||
              snapshot.data!.isEmpty ||
              snapshot.data == null) {
            return Center(
              child: Container(
                width: 200,
                height: 350,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Opacity(
                        opacity: 0.3,
                        child: Image.asset('assets/images/nodata.png'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                          message: "You haven't joint any classes yet!",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText.withOpacity(0.5))
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.data != null || snapshot.data != []) {
            print('snapshot is null or []: ${snapshot.data}');
            List<ClassesStudent> studentClasses = snapshot.data!;
            // Cập nhật dữ liệu vào Provider
            // saveListStudentClasses(studentClasses); //Hive
            saveListClassesStudent(studentClasses);
            Future.delayed(Duration.zero, () {
              classDataProvider.setClassesStudentList(studentClasses);
            });
            return SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      shrinkWrap: true,
                      itemCount: studentClasses.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = studentClasses[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context,'/DetailPage',arguments: {'studentClasses': data});
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      DetailPage(
                                    classesStudent: data,
                                  ),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              child: classInformation(
                                data.totalWeeks,
                                data.courseName,
                                data.teacherName,
                                data.courseID,
                                data.classType,
                                data.group,
                                data.subGroup,
                                data.shiftNumber,
                                data.roomNumber,
                                data.totalPresence,
                                data.totalLate,
                                data.totalAbsence,
                                data.progress,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Text('null');
      },
    );
  }

  // FutureBuilder<List<StudentClasses>> callAPI(
  //     BuildContext context, StudentClassesDataProvider classDataProvider) {
  //   return FutureBuilder(
  //     future: API(context).getStudentClass(), //Chinh parameter
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Padding(
  //             padding:
  //                 const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
  //             child: Column(
  //               children: [
  //                 customLoading(),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 customLoading(),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 customLoading(),
  //               ],
  //             ));
  //       } else if (snapshot.hasError) {
  //         print('Error');
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (snapshot.hasData) {
  //         if (snapshot.data == [] ||
  //             snapshot.data!.isEmpty ||
  //             snapshot.data == null) {
  //           return Center(
  //             child: Container(
  //               width: 200,
  //               height: 350,
  //               child: Center(
  //                 child: Column(
  //                   children: [
  //                     const SizedBox(
  //                       height: 100,
  //                     ),
  //                     Opacity(
  //                       opacity: 0.3,
  //                       child: Image.asset('assets/images/nodata.png'),
  //                     ),
  //                     const SizedBox(
  //                       height: 5,
  //                     ),
  //                     CustomText(
  //                         message: "You haven't joint any classes yet!",
  //                         fontSize: 11,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.primaryText.withOpacity(0.5))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         } else if (snapshot.data != null || snapshot.data != []) {
  //           print('snapshot is null or []: ${snapshot.data}');
  //           List<StudentClasses> studentClasses = snapshot.data!;
  //           // Cập nhật dữ liệu vào Provider
  //           saveListStudentClasses(studentClasses); //Hive
  //           Future.delayed(Duration.zero, () {
  //             classDataProvider.setStudentClassesList(studentClasses);
  //           });
  //           return SizedBox(
  //             height: 500,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 ListView.builder(
  //                   padding: const EdgeInsets.only(top: 20),
  //                   shrinkWrap: true,
  //                   itemCount: studentClasses.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     var data = studentClasses[index];
  //                     return Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 5, right: 5, bottom: 10),
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           // Navigator.pushNamed(context,'/DetailPage',arguments: {'studentClasses': data});
  //                           Navigator.push(
  //                             context,
  //                             PageRouteBuilder(
  //                               pageBuilder:
  //                                   (context, animation, secondaryAnimation) =>
  //                                       DetailPage(
  //                                 studentClasses: data,
  //                               ),
  //                               transitionDuration:
  //                                   const Duration(milliseconds: 200),
  //                               transitionsBuilder: (context, animation,
  //                                   secondaryAnimation, child) {
  //                                 return ScaleTransition(
  //                                   scale: animation,
  //                                   child: child,
  //                                 );
  //                               },
  //                             ),
  //                           );
  //                         },
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(
  //                             left: 5,
  //                             right: 5,
  //                           ),
  //                           child: classInformation(
  //                             data.classes.course.totalWeeks,
  //                             data.classes.course.courseName,
  //                             data.classes.teacher.teacherName,
  //                             data.classes.course.courseID,
  //                             data.classes.classType,
  //                             data.classes.group,
  //                             data.classes.subGroup,
  //                             data.classes.shiftNumber,
  //                             data.classes.roomNumber,
  //                             data.totalPresence,
  //                             data.totalLate,
  //                             data.totalAbsence,
  //                             data.progress,
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //       }
  //       return const Text('null');
  //     },
  //   );
  // }

  // Widget noInternet() {
  //   return Stack(
  //     children: [
  //       Center(
  //         child: Container(
  //           width: 200,
  //           height: 350,
  //           child: Center(
  //             child: Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 100,
  //                 ),
  //                 Opacity(
  //                   opacity: 0.5,
  //                   child: Image.asset('assets/images/nointernet.png'),
  //                 ),
  //                 const SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   "Please check your internet!",
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.grey.withOpacity(0.5),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       if (_showDialog)
  //         Center(
  //           child: Container(
  //             width: MediaQuery.of(context).size.width * 0.9, // test width
  //             height: MediaQuery.of(context).size.height * 0.25, // test height
  //             child: Stack(
  //               children: [
  //                 BackdropFilter(
  //                   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //                   child: AlertDialog(
  //                     backgroundColor: AppColors.primaryButton.withOpacity(0.2),
  //                     title: const Text(
  //                       'No Internet',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                     content: const Text(
  //                       'You can scan QR to take attendance offline',
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontSize: 14,
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                     actions: [
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             _showDialog = false;
  //                             // activeQR = true;
  //                           });
  //                         },
  //                         child: const Text(
  //                           'OK',
  //                           style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.normal),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ],
  //   );
  // }
  Widget noInternet() {
    return Center(
      child: Container(
        width: 200,
        height: 350,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/nointernet.png'),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Please check your internet!",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noInternetWithHive() {
    if (classesStudentBox.isOpen || classesStudentBox.isNotEmpty) {
      return SizedBox(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                shrinkWrap: true,
                controller: _controller,
                itemCount: classesStudentBox.values.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = classesStudentBox.getAt(index);
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    DetailPageOffline(
                              classesStudent: data,
                            ),
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: classInformation(
                          data!.totalWeeks,
                          data.courseName,
                          data.teacherName,
                          data.courseID,
                          data.classType,
                          data.group,
                          data.subGroup,
                          data.shiftNumber,
                          data.roomNumber,
                          data.totalPresence,
                          data.totalLate,
                          data.totalAbsence,
                          double.parse(data.progress.toString()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return noInternet();
    }
  }

  // Widget noInternetWithHive() {
  //   if (studentClassesBox.isOpen || studentClassesBox.isNotEmpty) {
  //     return SizedBox(
  //       height: 500,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ListView.builder(
  //             padding: const EdgeInsets.only(top: 20),
  //             shrinkWrap: true,
  //             itemCount: studentClassesBox.values.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               var data = studentClassesBox.getAt(index);
  //               return Padding(
  //                 padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
  //                 child: GestureDetector(
  //                   onTap: () {},
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                       left: 5,
  //                       right: 5,
  //                     ),
  //                     child: classInformation(
  //                       data!.classes.course.totalWeeks,
  //                       data.classes.course.courseName,
  //                       data.classes.teacher.teacherName,
  //                       data.classes.course.courseID,
  //                       data.classes.classType,
  //                       data.classes.group,
  //                       data.classes.subGroup,
  //                       data.classes.shiftNumber,
  //                       data.classes.roomNumber,
  //                       data.totalPresence,
  //                       data.totalLate,
  //                       data.totalAbsence,
  //                       data.progress,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return noInternet();
  //   }
  // }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(AppColors.primaryButton),
      ),
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
    int totalPresence,
    int totalAbsence,
    int totalLate,
    double progress,
  ) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 5,
                  offset: Offset(5.0, 4.0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
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
                        lineWidth: 6,
                        percent: progress, // Thay đổi giá trị tại đây
                        center: Text(
                          "$totalWeeks Weeks",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        backgroundColor: AppColors.secondaryText,
                        progressColor: AppColors.primaryButton,
                        animation: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Container(
                    width: 165,
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
                          message: classType,
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
                              message: group,
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
                              message: subGroup,
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
                      width: 1.5,
                      color: Colors.black),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: !activeForm
                        ? const EdgeInsets.only(top: 20, bottom: 20)
                        : const EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customRichText(
                          title: 'Total Presence: ',
                          message: '${totalPresence.ceil()}',
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
                          message: '${totalLate}',
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
                          message: '${totalAbsence.ceil()}',
                          fontWeightTitle: FontWeight.bold,
                          fontWeightMessage: FontWeight.w400,
                          colorText: AppColors.primaryText,
                          fontSize: 13,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget customLoading() {
    return Container(
        width: 410,
        height: 150,
        decoration: const BoxDecoration(
            color: Color.fromARGB(164, 245, 244, 244),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 5.0,
                  offset: Offset(3.0, 2.0))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 15),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(78, 158, 158, 158),
                  highlightColor: const Color.fromARGB(146, 255, 255, 255),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 200, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor: const Color.fromARGB(36, 255, 255, 255),
                        child: Container(
                            width: 200, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 200, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 200, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Shimmer.fromColors(
                            baseColor: const Color.fromARGB(78, 158, 158, 158),
                            highlightColor:
                                const Color.fromARGB(146, 255, 255, 255),
                            child: Container(
                                width: 50, height: 5, color: Colors.white)),
                        const SizedBox(
                          width: 5,
                        ),
                        Shimmer.fromColors(
                            baseColor: const Color.fromARGB(78, 158, 158, 158),
                            highlightColor:
                                const Color.fromARGB(146, 255, 255, 255),
                            child: Container(
                                width: 50, height: 5, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Shimmer.fromColors(
                  baseColor: const Color.fromARGB(78, 158, 158, 158),
                  highlightColor: const Color.fromARGB(146, 255, 255, 255),
                  child: Container(width: 2, height: 90, color: Colors.white)),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: !activeForm
                    ? const EdgeInsets.only(top: 20, bottom: 20)
                    : const EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 100, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 100, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(78, 158, 158, 158),
                        highlightColor:
                            const Color.fromARGB(146, 255, 255, 255),
                        child: Container(
                            width: 100, height: 15, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
