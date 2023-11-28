import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Authentication/CreateNewPassword.dart';
import 'package:attendance_system_nodejs/screens/Authentication/ForgotPassword.dart';
import 'package:attendance_system_nodejs/screens/Authentication/ForgotPasswordOTPPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/OTPPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/RegisterPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/SignInPage.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/screens/Home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentDataProvider()),
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
        '/Welcome': (context) => WelcomePage(),
        '/Login': (context) => SignInPage(),
        '/Register': (context) => RegisterPage(),
        '/ForgotPassword': (context) => ForgotPassword(),
        '/ForgotPasswordOTP': (context) => ForgotPasswordOTPPage(),
        '/CreateNewPassword': (context) => CreateNewPassword(),
        '/OTP': (context) => OTPPage(),
        '/OTPForgotPassword': (context) => OTPForgotPassword(),
        '/HomePage': (context) => HomePage(),
      },
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
