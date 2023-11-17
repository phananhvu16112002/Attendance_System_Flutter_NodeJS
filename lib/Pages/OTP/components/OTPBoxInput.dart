import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPBoxInput extends StatelessWidget {
  const OTPBoxInput({
    super.key,
    required this.otpController,
  });

  final OtpFieldController otpController;

  @override
  Widget build(BuildContext context) {
    return OTPTextField(
      controller: otpController,
      textFieldAlignment: MainAxisAlignment.spaceEvenly,
      length: 5,
      width: MediaQuery.of(context).size.width,
      outlineBorderRadius: 10,
      fieldWidth: 50,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      fieldStyle: FieldStyle.box,
      onChanged: (pin) {},
    );
  }
}
