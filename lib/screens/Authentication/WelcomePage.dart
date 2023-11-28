import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String schoolName = 'Ton Duc Thang University';
  String descriptionSchool =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum? Lorem ipsum dolor sit amet consectetur adipisicing elit. Sequi sit maiores, perferendis suscipit veniam ratione fuga cumque incidunt quam deleniti vitae maxime totam omnis quidem quo consectetur ad? Veniam, harum?';
  @override
  void dispose() {
    print("Welcome Page dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
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
                            message: schoolName,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryText,
                          )),
                        ],
                      ),
                      CustomText(
                          message: descriptionSchool,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CustomButton(
                            buttonName: 'Login',
                            backgroundColorButton: AppColors.primaryButton,
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            function: () =>
                                Navigator.of(context).pushNamed('/Login')),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CustomButton(
                          buttonName: 'Register',
                          backgroundColorButton: Colors.white,
                          borderColor: AppColors.primaryText,
                          textColor: AppColors.primaryText,
                          function: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed('/Register'),
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
