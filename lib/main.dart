import 'package:attendance_system_nodejs/providers/attendanceDetail_data_provider.dart';
import 'package:attendance_system_nodejs/providers/attendanceForm_data_provider.dart';
import 'package:attendance_system_nodejs/providers/socketServer_data_provider.dart';
import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Authentication/CreateNewPassword.dart';
import 'package:attendance_system_nodejs/screens/Authentication/ForgotPassword.dart';
import 'package:attendance_system_nodejs/screens/Authentication/ForgotPasswordOTPPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/OTPPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/RegisterPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/SignInPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/ReportAttendance.dart';
import 'package:attendance_system_nodejs/screens/Home/AfterAttendance.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/screens/Home/DetailReport.dart';
import 'package:attendance_system_nodejs/screens/Home/HomePage.dart';
import 'package:attendance_system_nodejs/screens/Home/Profile.dart';
import 'package:attendance_system_nodejs/TestApp/Test.dart';
import 'package:attendance_system_nodejs/TestApp/TestAvatar.dart';
import 'package:attendance_system_nodejs/TestApp/TestConnection.dart';
import 'package:attendance_system_nodejs/TestApp/TestCustomLoading.dart';
import 'package:attendance_system_nodejs/TestApp/TestTakeAttendance.dart';
import 'package:face_camera/face_camera.dart';
import 'package:attendance_system_nodejs/screens/Home/ReportPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this

  await FaceCamera.initialize(); //Add this
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentDataProvider()),
        ChangeNotifierProvider(create: (_) => StudentClassesDataProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceDetailDataProvider()),
        ChangeNotifierProvider(create: (_) => SocketServerProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceFormDataProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
  print('Hope to my code and my essay will success and get a high score in 2024. And i want to have a job in the next month. Hope so');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.backgroundColor),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/Welcome': (context) => const WelcomePage(),
        '/Login': (context) => const SignInPage(),
        '/Register': (context) => const RegisterPage(),
        '/ForgotPassword': (context) => const ForgotPassword(),
        '/ForgotPasswordOTP': (context) => const ForgotPasswordOTPPage(),
        '/CreateNewPassword': (context) => const CreateNewPassword(),
        '/OTP': (context) => const OTPPage(),
        '/HomePage': (context) => const HomePage(),
        '/ProfilePage': (context) => const ProfilePage(),
        '/DetailReport': (context) => const DetailReport(),
      },
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
