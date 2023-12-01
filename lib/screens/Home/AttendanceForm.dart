import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({super.key});

  @override
  State<AttendanceForm> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendanceForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Form',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryButton,
      ),
      body: bodyAttendance(),
    );
  }

  SingleChildScrollView bodyAttendance() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        // Column Tổng
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            infoClass(),
            const SizedBox(
              height: 15,
            ),
            infoLocation(),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
                buttonName: 'Scan your face',
                backgroundColorButton: AppColors.cardAttendance,
                borderColor: Colors.transparent,
                textColor: AppColors.primaryButton,
                function: () {},
                height: 40,
                width: 140,
                fontSize: 15),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                width: 350,
                height: 320,
                child: Center(child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CustomButton(
                  buttonName: 'Attendance',
                  backgroundColorButton: AppColors.primaryButton,
                  borderColor: Colors.transparent,
                  textColor: Colors.white,
                  function: () {},
                  height: 55,
                  width: 380,
                  fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Container infoLocation() {
    return Container(
      width: 405,
      height: 50,
      decoration: const BoxDecoration(
          color: AppColors.cardAttendance,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 15),
        child: customRichText(
            'Location: ',
            '19 Nguyen Huu Tho, District 7, Ho Chi Minh City',
            FontWeight.bold,
            FontWeight.w500,
            AppColors.primaryText,
            AppColors.primaryText),
      ),
    );
  }

  Container infoClass() {
    return Container(
      width: 405,
      height: 200,
      decoration: const BoxDecoration(
          color: AppColors.cardAttendance,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: Column(
        children: [
          const CustomText(
              message: 'Tuesday 7 January, 2023',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText),
          const SizedBox(
            height: 2,
          ),
          Container(
            height: 1,
            width: 405,
            color: const Color.fromARGB(105, 190, 188, 188),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 10),
                child: Container(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRichText(
                          'Class: ',
                          'Phát triển hệ thống thông tin doanh nghiệp',
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Status: ',
                          'Absent',
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.importantText),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          customRichText(
                              'Shift: ',
                              '4',
                              FontWeight.bold,
                              FontWeight.w500,
                              AppColors.primaryText,
                              AppColors.primaryText),
                          const SizedBox(
                            width: 10,
                          ),
                          customRichText(
                              'Room: ',
                              'A0405',
                              FontWeight.bold,
                              FontWeight.w500,
                              AppColors.primaryText,
                              AppColors.primaryText),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'Start Time: ',
                          '15:30 PM',
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                      const SizedBox(
                        height: 10,
                      ),
                      customRichText(
                          'End Time: ',
                          '16:30 PM',
                          FontWeight.bold,
                          FontWeight.w500,
                          AppColors.primaryText,
                          AppColors.primaryText),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                height: 140,
                width: 140,
                color: Colors.amber,
              )
            ],
          )
        ],
      ),
    );
  }

  RichText customRichText(
      String title,
      String message,
      FontWeight fontWeightTitle,
      FontWeight fontWeightMessage,
      Color colorTextTitle,
      Color colorTextMessage) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: title,
        style: TextStyle(
          fontWeight: fontWeightTitle,
          fontSize: 15,
          color: colorTextTitle,
        ),
      ),
      TextSpan(
        text: message,
        style: TextStyle(
          fontWeight: fontWeightMessage,
          fontSize: 15,
          color: colorTextMessage,
        ),
      ),
    ]));
  }
}
