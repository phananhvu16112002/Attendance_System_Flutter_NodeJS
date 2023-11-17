import 'package:attendance_system_nodejs/Pages/ForgotPassword/screens/ForgotPassword.dart';
import 'package:attendance_system_nodejs/Pages/OTP/screens/OTPPage.dart';
import 'package:attendance_system_nodejs/Pages/Register/screens/RegisterPage.dart';
import 'package:attendance_system_nodejs/Pages/SignIn/screens/SignInPage.dart';
import 'package:attendance_system_nodejs/Pages/Welcome/screens/WelcomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OTPPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
