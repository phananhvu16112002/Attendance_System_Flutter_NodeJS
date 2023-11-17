import 'package:attendance_system_nodejs/Pages/SignIn/screens/SignInPage.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.schoolName,
    required this.descriptionSchool,
  });

  final String schoolName;
  final String descriptionSchool;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ImageSlider(),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: CustomText(
                        message: widget.schoolName,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText,
                      )),
                    ],
                  ),
                  CustomText(
                      message: widget.descriptionSchool,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CustomButton(
                        buttonName: 'Login',
                        backgroundColorButton: AppColors.primaryButton,
                        borderColor: Colors.white,
                        textColor: Colors.white,
                        function: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => SignInPage()))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CustomButton(
                      buttonName: 'Register',
                      backgroundColorButton: Colors.white,
                      borderColor: AppColors.primaryText,
                      textColor: AppColors.primaryText,
                      function: () {},
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
