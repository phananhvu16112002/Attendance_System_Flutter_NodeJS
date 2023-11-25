import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/services/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isCheckPassword = false;
  bool isCheckConfirmPassword = false;
  final _formKey = GlobalKey<FormState>();
  RegExp upperCaseRegex = RegExp(r'[A-Z]');
  RegExp digitRegex = RegExp(r'[0-9]');

  bool isTDTUEmail(String email) {
    // Biểu thức chính quy để kiểm tra phần sau ký tự '@'
    final RegExp tdtuEmailRegExp =
        RegExp(r'^[0-9A-Z]+@(student\.)?tdtu\.edu\.vn$', caseSensitive: false);

    return tdtuEmailRegExp.hasMatch(email);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    emailAddress.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentDataProvider = Provider.of<StudentDataProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageSlider(),
            Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                              message: 'Register',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          const SizedBox(
                            height: 5,
                          ),
                          const CustomText(
                              message: 'Enter your personal information',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryText),
                          const SizedBox(
                            height: 20,
                          ),
                          const CustomText(
                              message: 'Username',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: username,
                            textInputType: TextInputType.text,
                            obscureText: false,
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: const Icon(null)),
                            hintText: 'Enter your userName',
                            onChanged: (value) {
                              studentDataProvider.setStudentName(value);
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 50) {
                                return 'Please check username(must not 50 characters) ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomText(
                              message: 'Email',
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
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: const Icon(null)),
                            hintText: 'Enter your email',
                            onChanged: (value) {
                              studentDataProvider.setStudentEmail(value);
                            },
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
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomText(
                            message: 'Password',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: password,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: isCheckPassword,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isCheckPassword = !isCheckPassword;
                                  });
                                },
                                icon: isCheckPassword
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            hintText: 'Enter your password',
                            onChanged: (value) {
                              studentDataProvider.setPassword(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              if (!upperCaseRegex.hasMatch(value)) {
                                return 'Password must be contain at least one uppercase letter';
                              }
                              if (!digitRegex.hasMatch(value)) {
                                return 'Password must be contain at least one digit number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomText(
                              message: 'Confirm Password',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: confirmPassword,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: isCheckConfirmPassword,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isCheckConfirmPassword =
                                        !isCheckConfirmPassword;
                                  });
                                },
                                icon: isCheckConfirmPassword
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)),
                            hintText: 'Confirm your password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              buttonName: 'Register',
                              backgroundColorButton: AppColors.primaryButton,
                              borderColor: Colors.white,
                              textColor: Colors.white,
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await Authenticate().registerUser(
                                        username.text,
                                        emailAddress.text,
                                        password.text);
                                    Navigator.pushNamed(context, '/OTP');
                                    showFlushBarNotification(
                                        context,
                                        "Successfully",
                                        "Please enter your OTP",
                                        3);
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  showFlushBarNotification(
                                      context,
                                      "Invalid Form",
                                      "Please complete the form property",
                                      3);
                                }
                              }),
                          const SizedBox(
                            height: 10,
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
                                  onTap: () =>
                                      Navigator.pushNamed(context, "/Login"),
                                  child: const CustomText(
                                      message: 'Log In',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.importantText),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
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
