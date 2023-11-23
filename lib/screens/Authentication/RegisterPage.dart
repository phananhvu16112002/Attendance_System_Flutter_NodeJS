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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final studentDataProvider = Provider.of<StudentDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlider(),
            Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              message: 'Register',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                              message: 'Enter your personal information',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryText),
                          SizedBox(
                            height: 20,
                          ),
                          CustomText(
                              message: 'Username',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: username,
                            textInputType: TextInputType.text,
                            obscureText: false,
                            suffixIcon: Icon(null),
                            hintText: 'Enter your userName',
                            onChanged: (value) {
                              studentDataProvider.setStudentName(value);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                              message: 'Email',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: emailAddress,
                            textInputType: TextInputType.emailAddress,
                            obscureText: false,
                            suffixIcon: Icon(null),
                            hintText: 'Enter your email',
                            onChanged: (value) {
                              studentDataProvider.setStudentEmail(value);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                            message: 'Password',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: password,
                            textInputType: TextInputType.visiblePassword,
                            obscureText: true,
                            suffixIcon: Icon(Icons.visibility),
                            hintText: 'Enter your password',
                            onChanged: (value) {
                              studentDataProvider.setPassword(value);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                              message: 'Confirm Password',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: confirmPassword,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              suffixIcon: Icon(Icons.visibility),
                              hintText: 'Confirm your password'),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              buttonName: 'Register',
                              backgroundColorButton: AppColors.primaryButton,
                              borderColor: Colors.white,
                              textColor: Colors.white,
                              function: () async {
                                if (_formKey.currentState!.validate()) {
                                  print(username.text.toString());
                                  print(emailAddress.text.toString());
                                  print(password.text.toString());
                                  try {
                                    await Authenticate().registerUser(
                                        username.text,
                                        emailAddress.text,
                                        password.text);
                                    Navigator.pushNamed(context, '/OTP');
                                    Flushbar(
                                      title: "Successfully",
                                      message: "Please Enter Your OTP",
                                      duration: Duration(seconds: 5),
                                    ).show(context);
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  Flushbar(
                                    title: "Invalid Form",
                                    message:
                                        "Please complete the form property",
                                    duration: Duration(seconds: 10),
                                  ).show(context);
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    message: 'Already have an account ? ',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryText),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, "/Login"),
                                  child: CustomText(
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
}
