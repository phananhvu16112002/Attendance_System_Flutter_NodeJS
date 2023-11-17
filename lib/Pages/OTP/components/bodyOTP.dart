import 'package:attendance_system_nodejs/Pages/OTP/components/OTPBoxInput.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

class bodyOTP extends StatelessWidget {
  const bodyOTP({
    super.key,
    required this.description,
    required this.otpController,
  });

  final String description;
  final OtpFieldController otpController;

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
                      message: "OTP Verification",
                      fontSize: 40,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: OTPBoxInput(otpController: otpController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonName: "Verify",
                      backgroundColorButton: AppColors.primaryButton,
                      borderColor: Colors.white,
                      textColor: Colors.white,
                      function: () {}),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            message: "Didn't recieved code ? ",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryText),
                        GestureDetector(
                          onTap: () {},
                          child: CustomText(
                              message: "Re-send",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.importantText),
                        )
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
