import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageSlider(),
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
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: reusableText(schoolName, 40,
                                  FontWeight.w800, AppColors.primaryText)),
                        ],
                      ),
                      reusableText(descriptionSchool, 15, FontWeight.bold,
                          AppColors.primaryText),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: reusableButton('Login', AppColors.primaryButton,
                            Colors.white, Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: reusableButton('Register', Colors.white,
                            AppColors.primaryText, AppColors.primaryText),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Text reusableText(
      String message, double fontSize, FontWeight fontWeight, Color color) {
    return Text(
      message,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }

  Container reusableButton(String buttonName, Color backgroundColorButton,
      Color borderColor, Color textColor) {
    return Container(
      height: 51,
      width: 400,
      decoration: BoxDecoration(
          color: backgroundColorButton,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 1, color: borderColor)),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(children: <Widget>[
        PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            ImageWelcome(context, 'assets/images/image_welcome1.jpg'),
            ImageWelcome(context, 'assets/images/image_welcome3.jpg'),
            ImageWelcome(context, 'assets/images/image_welcome2.jpg'),
          ],
        ),
      ]),
    );
  }

  ClipRRect ImageWelcome(BuildContext context, String imgPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imgPath,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
