import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class BodyForgotPassword extends StatelessWidget {
  const BodyForgotPassword({
    super.key,
    required this.description,
    required this.emailAddress,
  });

  final String description;
  final TextEditingController emailAddress;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  CustomText(
                      message: 'Forgot Your Password?',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                      message: description,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      message: "Email",
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
                      hintText: 'Enter your email address'),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomButton(
                        buttonName: "Send OTP",
                        backgroundColorButton: AppColors.primaryButton,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        function: () {}),
                  ),
                  SizedBox(
                    height: 15,
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
