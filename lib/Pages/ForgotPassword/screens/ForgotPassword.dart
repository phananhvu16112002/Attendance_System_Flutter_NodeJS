import 'package:attendance_system_nodejs/Pages/ForgotPassword/components/Body_Forgot_Password.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String description =
      "Don’t worry! If occurs. Please enter your email address or mobile number linked with your account!";
  TextEditingController emailAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyForgotPassword(
            description: description, emailAddress: emailAddress));
  }
}
