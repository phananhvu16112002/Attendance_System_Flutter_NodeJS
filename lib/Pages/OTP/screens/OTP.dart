import 'package:attendance_system_nodejs/Pages/OTP/components/BodyOTP.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String description =
      "Please enter the verification code we just sent on your email address.";
  TextEditingController OTPcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyOTP(codeOTP: OTPcode, description: description),);
  }
}