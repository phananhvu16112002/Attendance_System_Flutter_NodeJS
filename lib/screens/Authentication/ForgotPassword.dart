import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/services/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String description =
      "Don’t worry! If occurs. Please enter your email address or mobile number linked with your account!";
  TextEditingController emailAddress = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        message: 'Forgot Your Password?',
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
                      height: 15,
                    ),
                    const CustomText(
                        message: "Email",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: emailAddress,
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      prefixIcon: const Icon(null),
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: const Icon(null)),
                      hintText: 'Enter your email address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final RegExp tdtuEmailExp = RegExp(
                            r'^[0-9A-Z]+@(student\.)?tdtu\.edu\.vn$',
                            caseSensitive: false);
                        if (!tdtuEmailExp.hasMatch(value)) {
                          return 'Please check your valid email TDTU';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        studentDataProvider.setStudentEmail(value);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomButton(
                          fontSize: 20,
                          height: 60,
                          width: 400,
                          buttonName: "Send OTP",
                          backgroundColorButton: AppColors.primaryButton,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                bool check = await Authenticate()
                                    .forgotPassword(emailAddress.text);
                                if (check) {
                                  Navigator.pushNamed(
                                      context, '/ForgotPasswordOTP');
                                  showFlushBarNotification(
                                      context,
                                      'Verify OTP',
                                      'OTP has been sent to your email',
                                      3);
                                } else {
                                  showFlushBarNotification(context, 'Failed',
                                      'Email is not exist', 3);
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                              message: 'Already have an account ? ',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryText),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/Login", (route) => false);
                            },
                            child: const CustomText(
                                message: 'Log In',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.importantText),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
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
