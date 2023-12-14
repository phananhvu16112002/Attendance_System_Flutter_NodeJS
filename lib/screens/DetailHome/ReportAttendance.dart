import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportAttendance extends StatefulWidget {
  const ReportAttendance({super.key});

  @override
  State<ReportAttendance> createState() => _ReportAttendanceState();
}

class _ReportAttendanceState extends State<ReportAttendance> {
  final TextEditingController _lectuerController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _problemType = TextEditingController();
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: AppColors.colorAppbar,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                      message: 'Cross-Platform Programming',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  Row(
                    children: [
                      const CustomText(
                          message: 'CourseID: 502012',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(height: 10, width: 1, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomText(
                          message: 'Room: A0503',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(height: 10, width: 1, color: Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      const CustomText(
                          message: 'Shift: 5',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText(
                      message: 'Lectuer: Mai Van Manh',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15,right: 15),
          child: Container(
            width: 400,
            height: 700,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: AppColors.secondaryText,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.0))
                ]),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Text(
                    'Report Attendance',
                    style: GoogleFonts.inter(
                        color: AppColors.primaryButton,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                message: 'Send To:',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                            const SizedBox(
                              height: 5,
                            ),
                            customFormField(
                                'Mai Van Manh',
                                370,
                                50,
                                _lectuerController,
                                IconButton(
                                    onPressed: () {}, icon: const Icon(null)),
                                1,
                                true),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                                message: 'Topic',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                            const SizedBox(
                              height: 5,
                            ),
                            customFormField(
                                'Attendance Form 7 January, 2023',
                                370,
                                50,
                                _topicController,
                                IconButton(
                                    onPressed: () {}, icon: const Icon(null)),
                                1,
                                false),
                            const SizedBox(
                              height: 10,
                            ),
                            const CustomText(
                                message: 'Type Of Problem',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText),
                            const SizedBox(
                              height: 5,
                            ),
                            customFormField(
                                'Device Failure',
                                370,
                                50,
                                _problemType,
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.arrow_drop_down)),
                                1,
                                false),
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
                            customFormField(
                              'Description your problem',
                              370,
                              200,
                              _message,
                              IconButton(
                                  onPressed: () {}, icon: const Icon(null)),
                              200 ~/ 20,
                              false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const CustomText(
                                    message: 'Evidence of the problem: ',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    //Call bottom modal imagepicker gallery or camera
                                    CustomButton(
                                      buttonName: 'Upload File',
                                      backgroundColorButton:
                                          AppColors.cardAttendance,
                                      borderColor: AppColors.secondaryText,
                                      textColor: AppColors.primaryButton,
                                      colorShadow: Colors.transparent,
                                      function: () {},
                                      height: 35,
                                      width: 100,
                                      fontSize: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 300,
                                height: 200,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 13),
                                child: CustomButton(
                                    buttonName: 'Send',
                                    backgroundColorButton:
                                        AppColors.primaryButton,
                                    colorShadow: AppColors.colorShadow,
                                    borderColor: Colors.transparent,
                                    textColor: Colors.white,
                                    function: () {},
                                    height: 50,
                                    width: 370,
                                    fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  SizedBox customFormField(
      String hintText,
      double width,
      double height,
      TextEditingController textEditingController,
      IconButton iconButton,
      int maxLines,
      bool readOnly) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        maxLines: maxLines,
        readOnly: readOnly,
        controller: textEditingController,
        keyboardType: TextInputType.text,
        style: const TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: false,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: iconButton,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(92, 190, 188, 188))),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: AppColors.primaryButton),
            )),
      ),
    );
  }
}
