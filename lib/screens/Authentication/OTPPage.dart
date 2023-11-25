import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/services/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  OtpFieldController otpController = OtpFieldController();
  String description =
      "Please enter the verification code we just sent on your email address.";
  int secondsRemaining = 60; // Initial value for 1 minute
  bool canResend = true;
  @override
  Widget build(BuildContext context) {
    final studentDataProvider = Provider.of<StudentDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/forgot.png'),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        message: "OTP Verification",
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        message: description,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: OTPTextField(
                        controller: otpController,
                        textFieldAlignment: MainAxisAlignment.spaceEvenly,
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        outlineBorderRadius: 10,
                        fieldWidth: 50,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        fieldStyle: FieldStyle.box,
                        onChanged: (pin) {
                          studentDataProvider.setHashedOTP(pin);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        buttonName: "Verify",
                        backgroundColorButton: AppColors.primaryButton,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        function: () async {
                          try {
                            bool check = await Authenticate().verifyOTP(
                                studentDataProvider.userData.studentEmail,
                                studentDataProvider.userData.hashedOTP);
                            if (check == true) {
                              Navigator.pushNamed(context, '/Login');
                              Flushbar(
                                title: "Successfully",
                                message: "Login to use the app",
                                duration: Duration(seconds: 5),
                              ).show(context);
                            } else {
                              Flushbar(
                                title: "Failed",
                                message: "OTP is not valid",
                                duration: Duration(seconds: 5),
                              ).show(context);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                              message: "Didn't recieved code ? ",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText),
                          GestureDetector(
                            onTap: () {
                              if (canResend) {
                                // Start the countdown timer
                                startTimer();
                              }
                            },
                            child: CustomText(
                                message: canResend
                                    ? "Re-send"
                                    : "Resend in $secondsRemaining seconds",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.importantText),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          canResend = true;
          timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });

    // Disable the button during the countdown
    setState(() {
      canResend = false;
      secondsRemaining = 60; // Reset the timer to 1 minute
    });
  }
}
