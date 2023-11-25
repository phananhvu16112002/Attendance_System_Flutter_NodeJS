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
  bool isCheckNewPassword = false;
  bool isCheckConfirmPassword = false;
  final _formKey = GlobalKey<FormState>();
  RegExp upperCaseRegex = RegExp(r'[A-Z]');
  RegExp digitRegex = RegExp(r'[0-9]');

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
                child: Form(
                  key: _formKey,
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
                        obscureText: isCheckNewPassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isCheckNewPassword = !isCheckNewPassword;
                              });
                            },
                            icon: isCheckNewPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        hintText: "New Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!upperCaseRegex.hasMatch(value)) {
                            return 'Password must be contain at least one uppercase letter';
                          }
                          if (!digitRegex.hasMatch(value)) {
                            return 'Password must be contain at least one digit number';
                          }
                          return null;
                        },
                      ),
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
                        controller: confirmPassword,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: isCheckConfirmPassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isCheckConfirmPassword =
                                    !isCheckConfirmPassword;
                              });
                            },
                            icon: isCheckConfirmPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        hintText: "Confirm Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter confirm password";
                          }
                        },
                      ),
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
                            function: () {
                              if (_formKey.currentState!.validate()) {}
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
