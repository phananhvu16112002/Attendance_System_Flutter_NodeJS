import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class BodyCreateNewPassword extends StatelessWidget {
  const BodyCreateNewPassword({
    super.key,
    required this.description,
    required this.password,
  });

  final String description;
  final TextEditingController password;

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
              padding: const EdgeInsets.only(left: 20, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      message: "Create New Password",
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      message: description,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryText),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                      message: "New Password",
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
                      suffixIcon: Icon(Icons.visibility_off),
                      hintText: "New Password"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      message: "Confirm Password",
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
                      suffixIcon: Icon(Icons.visibility_off),
                      hintText: "Confirm Password"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                      buttonName: "Reset Password",
                      backgroundColorButton: AppColors.primaryButton,
                      borderColor: Colors.white,
                      textColor: Colors.white,
                      function: () {})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
