import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardAttendance,
      appBar: AppBar(
          title: const Text(
            'Reports',
            style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          actions: [
            Image.asset(
              'assets/icons/garbage.png',
              width: 30,
              height: 30,
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              cardReport(
                  'assets/icons/successfully.png',
                  'Quản trị hệ thống thông tin doanh nghiệp',
                  'Mai Van Manh',
                  'A0503',
                  '5',
                  'Approved',
                  '20/11/2023',
                  '10',
                  '21/11/2023',
                  '11:43 AM'),
              const SizedBox(
                height: 10,
              ),
              cardReport(
                  'assets/icons/pending.png',
                  'Quản trị hệ thống thông tin doanh nghiệp',
                  'Mai Van Manh',
                  'A0503',
                  '5',
                  'Pending',
                  '20/11/2023',
                  '10',
                  '21/11/2023',
                  '11:43 AM'),
              const SizedBox(
                height: 10,
              ),
              cardReport(
                  'assets/icons/cancel.png',
                  'Quản trị hệ thống thông tin doanh nghiệp',
                  'Mai Van Manh',
                  'A0503',
                  '5',
                  'Denied',
                  '20/11/2023',
                  '10',
                  '21/11/2023',
                  '11:43 AM'),
              const SizedBox(
                height: 10,
              ),
              cardReport(
                  'assets/icons/cancel.png',
                  'Quản trị hệ thống thông tin doanh nghiệp',
                  'Mai Van Manh',
                  'A0503',
                  '5',
                  'Denied',
                  '20/11/2023',
                  '10',
                  '21/11/2023',
                  '11:43 AM'),
            ],
          ),
        ),
      ),
    );
  }

  Container cardReport(
      String pathStatus,
      String className,
      String lectuerName,
      String room,
      String shift,
      String status,
      String dateReport,
      String week,
      String returnDate,
      String timeReport) {
    return Container(
      width: 405,
      height: 200,
      decoration: const BoxDecoration(
          color: AppColors.cardReport,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: AppColors.secondaryText,
                blurRadius: 5.0,
                offset: Offset(0.0, 0.0))
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              pathStatus,
              width: 35,
              height: 35,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                customRichText(
                    'Class: ',
                    className,
                    FontWeight.bold,
                    FontWeight.w500,
                    AppColors.primaryText,
                    AppColors.primaryText),
                const SizedBox(
                  height: 5,
                ),
                customRichText(
                    'Lectuer: ',
                    lectuerName,
                    FontWeight.bold,
                    FontWeight.w500,
                    AppColors.primaryText,
                    AppColors.primaryText),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    customRichText(
                        'Room: ',
                        room,
                        FontWeight.bold,
                        FontWeight.w500,
                        AppColors.primaryText,
                        AppColors.primaryText),
                    const SizedBox(
                      width: 10,
                    ),
                    customRichText(
                        'Shift: ',
                        shift,
                        FontWeight.bold,
                        FontWeight.w500,
                        AppColors.primaryText,
                        AppColors.primaryText),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                customRichText(
                    'Status: ',
                    status,
                    FontWeight.bold,
                    FontWeight.w500,
                    AppColors.primaryText,
                    getColorBasedOnStatus(status)),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    customRichText(
                        'Date: ',
                        dateReport,
                        FontWeight.bold,
                        FontWeight.w500,
                        AppColors.primaryText,
                        AppColors.primaryText),
                    const SizedBox(
                      width: 10,
                    ),
                    customRichText(
                        'Week: ',
                        week,
                        FontWeight.bold,
                        FontWeight.w500,
                        AppColors.primaryText,
                        AppColors.primaryText),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                customRichText(
                    'Return Date: ',
                    returnDate,
                    FontWeight.bold,
                    FontWeight.w500,
                    AppColors.primaryText,
                    AppColors.primaryText),
                const SizedBox(
                  height: 5,
                ),
                customRichText(
                    'Time: ',
                    timeReport,
                    FontWeight.bold,
                    FontWeight.w500,
                    AppColors.primaryText,
                    AppColors.primaryText),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                height: 180,
                width: 2,
                color: AppColors.primaryText),
          ),
          const SizedBox(
            width: 30,
          ),
          const CustomText(
              message: 'Detail',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryButton)
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

  Color getColorBasedOnStatus(String status) {
    if (status.contains('Approved')) {
      return AppColors.textApproved;
    } else if (status.contains('Pending')) {
      return const Color.fromARGB(231, 196, 123, 34);
    } else if (status.contains('Denied')) {
      return AppColors.importantText;
    } else {
      // Mặc định hoặc trường hợp khác
      return AppColors.primaryText;
    }
  }
}
