import 'package:attendance_system_nodejs/providers/attendanceDetail_data_provider.dart';
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
import 'package:attendance_system_nodejs/screens/Home/AttendanceForm.dart';
import 'package:attendance_system_nodejs/screens/DetailHome/DetailPage.dart';
import 'package:attendance_system_nodejs/screens/Home/DetailReport.dart';
import 'package:attendance_system_nodejs/screens/Home/HomePage.dart';
import 'package:attendance_system_nodejs/screens/Home/Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentDataProvider()),
        ChangeNotifierProvider(create: (_) => StudentClassesDataProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceDetailDataProvider())
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
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
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
        '/AttendanceForm': (context) => const AttendanceForm(),
        '/ProfilePage': (context) => const ProfilePage(),
        '/DetailReport': (context) => const DetailReport(),
        '/DetailPage': (context) => const DetailPage()
      },
      home: const DetailPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
