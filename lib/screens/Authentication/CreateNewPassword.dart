import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String description =
      'Your new password must be unique from those previously used';
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
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                        message: "Create New Password",
                        fontSize: 42,
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
                      height: 20,
                    ),
                    const CustomText(
                        message: "New Password",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: password,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.visibility_off)),
                        hintText: "New Password"),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                        message: "Confirm Password",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: password,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.visibility_off)),
                        hintText: "Confirm Password"),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CustomButton(
                          buttonName: "Reset Password",
                          backgroundColorButton: AppColors.primaryButton,
                          borderColor: Colors.white,
                          textColor: Colors.white,
                          function: () {}),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
