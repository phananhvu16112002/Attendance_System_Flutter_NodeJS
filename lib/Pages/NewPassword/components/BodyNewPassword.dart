import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class BodyNewPassword extends StatelessWidget {
  const BodyNewPassword({super.key,
  required this.newPassword,
  required this.confirmPassword});

  final TextEditingController newPassword;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/forgot.png'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  CustomText(message: "Create new password", fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  CustomText(message: "Your new password must be unique from those previously used", fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
                  SizedBox(height: 10),
                  CustomText(message: "New password", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  CustomTextField(controller: newPassword, textInputType: TextInputType.visiblePassword, obscureText: true, suffixIcon: Icon(Icons.visibility), hintText: "Enter Password"),
                  SizedBox(height: 10),
                  CustomText(message: "Confirm password", fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  CustomTextField(controller: confirmPassword, textInputType: TextInputType.visiblePassword, obscureText: true, suffixIcon: Icon(Icons.visibility), hintText: "Enter Confirm Password"),
                  SizedBox(height: 10),
                  CustomButton(buttonName: "Reset Password", backgroundColorButton: AppColors.primaryButton, borderColor: Colors.white, textColor: Colors.white, function: () {})
               ],
            ),
          )
        ],
      ),
    );
  }
}