import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.emailAddress,
    required this.password,
  });

  final TextEditingController emailAddress;
  final TextEditingController password;

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
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    message: 'Login',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    message: 'Login to continue using the app',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    message: 'Email',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: emailAddress,
                      textInputType: TextInputType.emailAddress,
                      obscureText: false,
                      suffixIcon: Icon(null),
                      hintText: "Enter your email"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    message: 'Password',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: password,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: true,
                      suffixIcon: Icon(Icons.visibility),
                      hintText: "Enter your password"),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 250),
                    child: CustomText(
                      message: 'Forgot Password?',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.importantText,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomButton(
                        buttonName: 'Login',
                        backgroundColorButton: AppColors.primaryButton,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        function: () {}),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Build third login
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 0.8,
                          width: 120,
                          color: AppColors.secondaryText,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          message: 'Or Login With',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryText,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 0.8,
                          width: 120,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildIcon('assets/icons/google.png'),
                        const SizedBox(
                          width: 20,
                        ),
                        buildIcon('assets/icons/google.png'),
                        const SizedBox(
                          width: 20,
                        ),
                        buildIcon('assets/icons/google.png'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        message: "Don't you have an account ? ",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: CustomText(
                          message: 'Register',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.importantText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildIcon(String path) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: AppColors.secondaryText)),
      child: Image.asset(
        path,
        height: 40,
        width: 40,
      ),
    );
  }
}
