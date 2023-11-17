import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class BodyOTP extends StatelessWidget {
  const BodyOTP({super.key,
                required this.codeOTP,
                required this.description});

  final TextEditingController codeOTP;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/forgot.png'),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(message: "OTP Verification", fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryText),
                  SizedBox(height: 5,),
                  CustomText(message: description, fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
                  SizedBox(height: 40,),
                  CustomTextField(controller: codeOTP, textInputType: TextInputType.number, obscureText: false, suffixIcon: Icon(null), hintText: "Enter OTP"),
                  SizedBox(height: 40,),
                  CustomButton(buttonName: "Verify", backgroundColorButton: AppColors.primaryButton, borderColor: Colors.white, textColor: Colors.white, function: () => {}),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(message: "Didn't recieve code?", fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryText),
                        GestureDetector(onTap: () => {}, child: CustomText(message: " Resend", fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.importantText))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}