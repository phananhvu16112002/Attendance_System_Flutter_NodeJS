import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class DetailReport extends StatefulWidget {
  const DetailReport({super.key});

  @override
  State<DetailReport> createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Detail Report',
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Class',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 5,
              ),
              customCard('Introduction of networking', 410, 50, 2),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Lectuer',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 5,
              ),
              customCard('Truong Dinh Tu', 410, 50, 2),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Room',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('A0505',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(108, 0, 0, 0),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Shift',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('4',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(108, 0, 0, 0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Date Report',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('23/11/2023',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(108, 0, 0, 0),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Date Response',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('25/11/2023',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(108, 0, 0, 0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Status',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('Approved',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textApproved,
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                          message: 'Time Response',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(139, 238, 246, 254),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border(
                                top: BorderSide(color: AppColors.secondaryText),
                                left:
                                    BorderSide(color: AppColors.secondaryText),
                                right:
                                    BorderSide(color: AppColors.secondaryText),
                                bottom: BorderSide(
                                    color: AppColors.secondaryText))),
                        child: const Center(
                          child: Text('15:11 PM',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(108, 0, 0, 0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Type of problem',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 5,
              ),
              customCard('Device Failure', 410, 50, 2),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Message',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 5,
              ),
              customCard(
                  'adasdasdasdasdasdasdasdsad1231231adsdaxzcxzdae123asdaczxczdasdq123easdzczxasdasdasdas',
                  410,
                  150,
                  10),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  message: 'Evidence of problem',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
              const SizedBox(
                height: 5,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 400,
                height: 400,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container customCard(
    String message,
    double width,
    double height,
    int maxLines,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          color: Color.fromARGB(139, 238, 246, 254),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border(
              top: BorderSide(color: AppColors.secondaryText),
              left: BorderSide(color: AppColors.secondaryText),
              right: BorderSide(color: AppColors.secondaryText),
              bottom: BorderSide(color: AppColors.secondaryText))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15),
        child: Text(
          message,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(108, 0, 0, 0)),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
