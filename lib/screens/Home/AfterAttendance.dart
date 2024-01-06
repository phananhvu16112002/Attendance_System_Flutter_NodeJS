import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class AfterAttendance extends StatefulWidget {
  const AfterAttendance({super.key});

  @override
  State<AfterAttendance> createState() => _AfterAttendanceState();
}

class _AfterAttendanceState extends State<AfterAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 115, top: 70),
            child: Column(
              children: [
                GifView.asset(
                  'assets/images/test.gif',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                    message: 'Attendance Successfully',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: const Color.fromARGB(40, 0, 0, 0)),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    message: 'Class: ',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText),
                CustomText(
                    message: 'Cross-Platform Programming',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    message: 'Status: ',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText),
                CustomText(
                    message: 'Successfully',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textApproved)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    message: 'Time: ',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText),
                CustomText(
                    message: '7/12/2023 - 16:40:43',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    message: 'Location: ',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText),
                CustomText(
                    message: '19 Nguyen Huu Tho, District 7, HCMC',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText)
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    message: 'Image Evidence: ',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 200,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 165,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.secondaryText,
                      blurRadius: 20,
                      offset: Offset(0, -2))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    buttonName: 'Back to home',
                    colorShadow: AppColors.colorShadow,
                    backgroundColorButton: AppColors.primaryButton,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    function: () {},
                    height: 60,
                    width: 350,
                    fontSize: 20),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const CustomText(
                      message: 'Take a screenshot',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryButton),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
