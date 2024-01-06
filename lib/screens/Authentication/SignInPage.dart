import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Authentication/ForgotPassword.dart';
import 'package:attendance_system_nodejs/screens/Authentication/RegisterPage.dart';
import 'package:attendance_system_nodejs/screens/Home/HomePage.dart';
import 'package:attendance_system_nodejs/services/Authenticate.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCheckPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailAddress.dispose();
    password.dispose();
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
          const ImageSlider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      message: 'Login',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const CustomText(
                      message: 'Login to continue using the app',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryText,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      message: 'Email',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      readOnly: false,
                      controller: emailAddress,
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      prefixIcon: const Icon(null),
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: const Icon(null)),
                      hintText: "Enter your email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
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
                      readOnly: false,
                      controller: password,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isCheckPassword,
                      prefixIcon: const Icon(null),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isCheckPassword = !isCheckPassword;
                            });
                          },
                          icon: isCheckPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      hintText: "Enter your password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 230),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ForgotPassword(),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const CustomText(
                              message: 'Forgot Password?',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.importantText)),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: CustomButton(
                          fontSize: 20,
                          height: 60,
                          width: 400,
                          buttonName: 'Login',
                          colorShadow: AppColors.colorShadow,
                          backgroundColorButton: AppColors.primaryButton,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                String check = await Authenticate()
                                    .login(emailAddress.text, password.text);
                                if (check == '' || check.isEmpty) {
                                  var studentID = await SecureStorage() //520h0380
                                      .readSecureData('studentID');
                                  var studentEmail = await SecureStorage() //520h3080@student.tdtu.edu
                                      .readSecureData('studentEmail');
                                  var studentName = await SecureStorage()
                                      .readSecureData('studentName');
                                  studentDataProvider.setStudentID(studentID);
                                  studentDataProvider
                                      .setStudentEmail(studentEmail);
                                  studentDataProvider
                                      .setStudentName(studentName);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          HomePage(),
                                      transitionDuration:
                                          const Duration(milliseconds: 1000),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var curve = Curves.easeInOutCubic;
                                        var tween = Tween(
                                                begin: const Offset(1.0, 0.0),
                                                end: Offset.zero)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                    (route) => false,
                                  );

                                  // ignore: use_build_context_synchronously
                                  Flushbar(
                                    title: "Successfully",
                                    message: "Processing Data...",
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Flushbar(
                                    title: "Failed",
                                    message: "$check",
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              Flushbar(
                                title: "Invalid Form",
                                message: "Please complete the form property",
                                duration: const Duration(seconds: 10),
                              ).show(context);
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Build third login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
                          message: "Don't you have an account ? ",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const RegisterPage(),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var curve = Curves.easeInOutCubic;
                                  var tween = Tween(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const CustomText(
                            message: 'Register',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.importantText,
                          ),
                        ),
                      ],
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

  Container buildIcon(String path) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: AppColors.secondaryText)),
      child: Image.asset(
        path,
        height: 40,
        width: 40,
      ),
    );
  }
}
