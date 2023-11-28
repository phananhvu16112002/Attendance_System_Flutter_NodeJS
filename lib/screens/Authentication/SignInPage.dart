import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
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
  bool isCheckPassword = false;

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
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
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
                      controller: emailAddress,
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
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
                      padding: const EdgeInsets.only(left: 250),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ('/ForgotPassword'));
                        },
                        child: const CustomText(
                          message: 'Forgot Password?',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.importantText,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomButton(
                          buttonName: 'Login',
                          backgroundColorButton: AppColors.primaryButton,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                bool check = await Authenticate()
                                    .login(emailAddress.text, password.text);
                                // var accessToken = await SecureStorage()
                                //     .readSecureData('accessToken');
                                // var refreshToken = await SecureStorage()
                                //     .readSecureData('refreshToken');
                                // studentDataProvider.setAccessToken(accessToken);
                                // studentDataProvider
                                //     .setRefreshToken(refreshToken);
                                if (check) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, ('/HomePage'), (route) => false);
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
                                    message: "Email or Password is not correct",
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
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 0.8,
                            width: 120,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const CustomText(
                            message: 'Or Login With',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: AppColors.primaryText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 0.8,
                            width: 120,
                            color: AppColors.secondaryText,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildIcon('assets/icons/google.png'),
                          const SizedBox(
                            width: 20,
                          ),
                          buildIcon('assets/icons/google.png'),
                          const SizedBox(
                            width: 20,
                          ),
                          buildIcon('assets/icons/google.png'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                            Navigator.pushNamedAndRemoveUntil(
                                context, ('/Register'), (route) => false);
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
