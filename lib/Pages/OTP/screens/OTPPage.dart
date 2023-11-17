import 'package:attendance_system_nodejs/Pages/OTP/components/bodyOTP.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OtpFieldController otpController = OtpFieldController();
  String description =
      "Please enter the verification code we just sent on your email address.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyOTP(description: description, otpController: otpController),
    );
  }
}
