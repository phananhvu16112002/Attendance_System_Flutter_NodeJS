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

class ForgotPasswordOTPPage extends StatefulWidget {
  const ForgotPasswordOTPPage({super.key});

  @override
  State<ForgotPasswordOTPPage> createState() => _ForgotPasswordOTPPageState();
}

class _ForgotPasswordOTPPageState extends State<ForgotPasswordOTPPage> {
  OtpFieldController otpController = OtpFieldController();
  String description =
      "Please enter the verification code we just sent on your email address.";
  int secondsRemaining = 60; // Initial value for 1 minute
  bool canResend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                        fontSize: 20,
                        height: 60,
                        width: 400,
                        buttonName: "Verify",
                        backgroundColorButton: AppColors.primaryButton,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        function: () async {
                          try {
                            bool checkLogin = await Authenticate()
                                .verifyForgotPassword(
                                    studentDataProvider.userData.studentEmail,
                                    studentDataProvider.userData.hashedOTP);
                            if (checkLogin == true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(
                                  context, '/CreateNewPassword');
                              // ignore: use_build_context_synchronously
                              Flushbar(
                                title: "Successfully",
                                message: "Create new password",
                                duration: const Duration(seconds: 5),
                              ).show(context);
                            } else {
                              // ignore: use_build_context_synchronously
                              Flushbar(
                                title: "Failed",
                                message: "OTP is not valid",
                                duration: const Duration(seconds: 5),
                              ).show(context);
                            }
                          } catch (e) {
                            // ignore: avoid_print
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
                            onTap: () async {
                              if (canResend) {
                                // true
                                // Start the countdown timer
                                bool check = await Authenticate().resendOTP(
                                    studentDataProvider.userData.studentEmail);
                                if (check) {
                                  // ignore: use_build_context_synchronously
                                  showFlushBarNotification(
                                      context,
                                      'Resend OTP',
                                      "OTP has been sent your email",
                                      3);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showFlushBarNotification(context,
                                      'Failed resend OTP', 'message', 3);
                                }
                                startTimer();
                              }
                            },
                            child: CustomText(
                                message: canResend // true
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

  // void startTimer() {
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (secondsRemaining > 0) {
  //         secondsRemaining--;
  //       } else {
  //         canResend = true;
  //         timer.cancel(); // Stop the timer when it reaches 0
  //       }
  //     });
  //   });

  //   // Disable the button during the countdown
  //   setState(() {
  //     canResend = false;
  //     secondsRemaining = 60; // Reset the timer to 1 minute
  //   });
  // }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          canResend = true;
        });
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  void showFlushBarNotification(
      BuildContext context, String title, String message, int second) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: second),
    ).show(context);
  }
}
