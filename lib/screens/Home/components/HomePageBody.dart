import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  TextEditingController searchController = TextEditingController();
  bool activeQR = false;
  bool activeForm = false;
  Barcode? result;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // ignore: avoid_print
      print('Scanned Data: $scanData');
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //Column Tổng body
        child: Column(
      children: [
        Stack(children: [
          customAppBar(context),
          //Search Bar
          Positioned(
            top: 285,
            left: 25,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.secondaryText,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.0))
                    ]),
                //Fix PrefixIcon
                child: CustomTextField(
                  readOnly: false,
                  controller: searchController,
                  textInputType: TextInputType.text,
                  obscureText: false,
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(null)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search class | Example: CourseID,..',
                )),
          ),
          //Body 2
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 350),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activeQR = false;
                        });
                      },
                      child: Container(
                        width: 142,
                        height: 30,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: activeQR
                                ? Colors.white
                                : AppColors.primaryButton,
                            border: Border.all(
                                color: AppColors.secondaryText, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: CustomText(
                                message: 'Take Attendance',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: activeQR
                                    ? AppColors.primaryText
                                    : Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activeQR = true;
                        });
                      },
                      child: Container(
                        width: 142,
                        height: 26,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: activeQR
                                ? AppColors.primaryButton
                                : Colors.white,
                            border: Border.all(
                                color: AppColors.secondaryText, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: CustomText(
                                message: 'Scan QR',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: activeQR
                                    ? Colors.white
                                    : AppColors.primaryText)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (!activeQR)
                  Column(
                    children: [
                      classInformation(true),
                      const SizedBox(
                        height: 10,
                      ),
                      classInformation(false),
                      const SizedBox(
                        height: 10,
                      ),
                      classInformation(false),
                      const SizedBox(
                        height: 10,
                      ),
                      classInformation(false),
                    ],
                  )
                else
                  Container(
                    height: 500,
                    child: Column(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  message: 'SCAN QR CODE',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText),
                              CustomText(
                                  message:
                                      'Scanning will be started automatically',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryText),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 400,
                          width: 400,
                          color: Colors.black,
                          // child: QRView(
                          //     key: qrKey, onQRViewCreated: _onQRViewCreated),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ]),
      ],
    ));
  }

  Container customAppBar(BuildContext context) {
    return Container(
      height: 320,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.colorAppbar,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CustomText(
                            message: 'Hi, ',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.thirdText),
                        CustomText(
                            message: 'Anh Vu',
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: const Color.fromARGB(106, 255, 255, 255),
                      width: 140,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_3_outlined,
                                size: 11, color: AppColors.thirdText),
                            CustomText(
                                message: '520H0696 | ',
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.thirdText),
                            CustomText(
                                message: 'Student',
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.thirdText),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 11, color: Colors.white),
                        CustomText(
                            message:
                                'Adress: 19 Nguyen Huu Tho, District 7, HCMC ',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                              child: Icon(Icons.grid_view_outlined))),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(106, 255, 255, 255)),
          const SizedBox(
            height: 5,
          ),
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
                selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
                selectedDateStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                showMonthPicker: false,
                monthPickerType: MonthPickerType.dropDown,
                monthStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                padding: EdgeInsets.only(top: 5, bottom: 15, left: 10)),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNumMonth,
              width: 65,
              height: 85,
              borderColor: Color.fromARGB(61, 207, 204, 204),
              //activeDay
              activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dayNumStyle: TextStyle(
                      color: AppColors.primaryButton,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(
                      color: AppColors.primaryButton,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  monthStrStyle: TextStyle(
                      color: AppColors.primaryButton,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              //inactiveDay
              inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  monthStrStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              //TodayStyle
              todayStyle: DayStyle(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(78, 219, 217, 217),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dayNumStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  dayStrStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  monthStrStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(106, 255, 255, 255)),
        ],
      ),
    );
  }

  Container classInformation(bool activeForm) {
    return Container(
        width: 405,
        height: 120,
        decoration: BoxDecoration(
            color: !activeForm ? Colors.white : AppColors.cardHome,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.0))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 55,
                  height: 80,
                  child: CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 5,
                    percent: 0.5, // Thay đổi giá trị tại đây
                    center: const Text(
                      "15 Weeks",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    backgroundColor:
                        !activeForm ? AppColors.secondaryText : Colors.white,
                    progressColor:
                        !activeForm ? AppColors.primaryButton : Colors.green,
                    animation: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Container(
                width: 155,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customRichText(
                        'Course: ',
                        'Quản lý chất lượng dịch vụ và an toàn thông tin',
                        FontWeight.bold,
                        FontWeight.w400,
                        AppColors.primaryText),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText('Lectuer: ', 'Mai Van Manh', FontWeight.bold,
                        FontWeight.w400, AppColors.primaryText),
                    const SizedBox(
                      height: 5,
                    ),
                    customRichText('CourseID: ', '520H0696', FontWeight.bold,
                        FontWeight.w400, AppColors.primaryText),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        customRichText('Shift: ', '5', FontWeight.bold,
                            FontWeight.w400, AppColors.primaryText),
                        const SizedBox(
                          width: 10,
                        ),
                        customRichText('Class: ', 'A0405', FontWeight.bold,
                            FontWeight.w400, AppColors.primaryText),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  height: 75,
                  width: 2,
                  color: const Color.fromARGB(96, 190, 188, 188)),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customRichText('Total Attendance: ', '5', FontWeight.bold,
                      FontWeight.w400, AppColors.primaryText),
                  const SizedBox(
                    height: 5,
                  ),
                  customRichText('Total Late: ', '5', FontWeight.bold,
                      FontWeight.w400, AppColors.primaryText),
                  const SizedBox(
                    height: 5,
                  ),
                  customRichText('Total Absent: ', '5', FontWeight.bold,
                      FontWeight.w400, AppColors.primaryText),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: CustomButton(
                        buttonName: 'Attendance',
                        backgroundColorButton: !activeForm
                            ? AppColors.primaryButton
                            : Colors.green,
                        borderColor: Colors.transparent,
                        textColor: Colors.white,
                        function: () {},
                        height: 20,
                        width: 80,
                        fontSize: 11),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  RichText customRichText(
      String title,
      String message,
      FontWeight fontWeightTitle,
      FontWeight fontWeightMessage,
      Color colorText) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: title,
        style: TextStyle(
          fontWeight: fontWeightTitle,
          fontSize: 12,
          color: colorText,
        ),
      ),
      TextSpan(
        text: message,
        style: TextStyle(
          fontWeight: fontWeightMessage,
          fontSize: 12,
          color: colorText,
        ),
      ),
    ]));
  }
}
