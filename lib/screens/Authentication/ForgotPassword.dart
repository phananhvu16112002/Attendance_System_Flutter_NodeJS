import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String description =
      "Don’t worry! If occurs. Please enter your email address or mobile number linked with your account!";
  TextEditingController emailAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                  const CustomText(
                      message: 'Forgot Your Password?',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      message: description,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryText),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                      message: "Email",
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
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: const Icon(null)),
                      hintText: 'Enter your email address'),
                  const SizedBox(
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
                  const SizedBox(
                    height: 15,
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
                          onTap: () {},
                          child: const CustomText(
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
    ));
  }
}
