import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({
    super.key,
    required this.username,
    required this.emailAddress,
    required this.password,
    required this.confirmPassword,
  });

  final TextEditingController username;
  final TextEditingController emailAddress;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSlider(),
          Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
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
                        height: 5,
                      ),
                      CustomTextField(
                          controller: username,
                          textInputType: TextInputType.text,
                          obscureText: false,
                          suffixIcon: Icon(null),
                          hintText: 'Enter your userName'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          message: 'Email',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                          controller: emailAddress,
                          textInputType: TextInputType.emailAddress,
                          obscureText: false,
                          suffixIcon: Icon(null),
                          hintText: 'Enter your email'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          message: 'Password',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                          controller: password,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          suffixIcon: Icon(Icons.visibility),
                          hintText: 'Enter your password'),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          message: 'Confirm Password',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      SizedBox(
                        height: 5,
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
                          function: () {}),
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
                              onTap: () {},
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
              ))
        ],
      ),
    );
  }
}
