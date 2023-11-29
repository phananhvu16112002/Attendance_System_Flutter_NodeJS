import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/screens/Authentication/WelcomePage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = SecureStorage();
  String? accessToken;
  String? refreshToken;
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadToken();
  }

  Future<void> _loadToken() async {
    String? loadToken = await storage.readSecureData('accessToken');
    String? refreshToken1 = await storage.readSecureData('refreshToken');
    if (loadToken.isEmpty ||
        refreshToken1.isEmpty ||
        loadToken.contains('No Data Found') ||
        refreshToken1.contains('No Data Found')) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } else {
      setState(() {
        accessToken = loadToken;
        refreshToken = refreshToken1;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: customFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customBottomNavigationBar(),
        body: SingleChildScrollView(
            //Column Tổng body
            child: Column(
          children: [
            Stack(children: [
              Container(
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
                      child: informationUser(),
                    ),
                    Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromARGB(106, 255, 255, 255)),
                    const SizedBox(
                      height: 5,
                    ),
                    customCalendarTimeline(),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromARGB(106, 255, 255, 255)),
                  ],
                ),
              ),
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
                    child: CustomTextField(
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
                          onTap: () {},
                          child: Container(
                            width: 142,
                            height: 30,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: AppColors.primaryButton,
                                border: Border.all(
                                    color: AppColors.secondaryText, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Center(
                                child: CustomText(
                                    message: 'Take Attendance',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 142,
                            height: 26,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColors.secondaryText, width: 1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Center(
                                child: CustomText(
                                    message: 'Scan QR',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryText)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    classInformation(),
                    const SizedBox(
                      height: 10,
                    ),
                    classInformation(),
                    const SizedBox(
                      height: 10,
                    ),
                    classInformation(),
                    const SizedBox(
                      height: 10,
                    ),
                    classInformation(),
                  ],
                ),
              ),
            ]),
          ],
        )));
  }

  Container classInformation() {
    return Container(
        width: 405,
        height: 120,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: AppColors.secondaryText,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.0))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      message: 'Course: Mobile Cross-Platform',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: 3,
                  ),
                  CustomText(
                      message: 'Lectuer: Mai Van Manh',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: 3,
                  ),
                  CustomText(
                      message: 'CourseID: 520H0696',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  SizedBox(
                    height: 3,
                  ),
                  CustomText(
                      message: 'Shift: 5 | Class: A0405',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                ],
              ),
              const SizedBox(
                width: 10,
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
                  const CustomText(
                      message: 'Total Attendance: 10',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 3,
                  ),
                  const CustomText(
                      message: 'Total Late: 5',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 3,
                  ),
                  const CustomText(
                      message: 'Total Absent: 5',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: CustomButton(
                        buttonName: 'Attendance',
                        backgroundColorButton: AppColors.primaryButton,
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

  EasyDateTimeLine customCalendarTimeline() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        //`selectedDate` the new date selected.
      },
      headerProps: const EasyHeaderProps(
          selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
          selectedDateStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          showMonthPicker: false,
          monthPickerType: MonthPickerType.dropDown,
          monthStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            dayStrStyle: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
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
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            dayStrStyle: TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
            monthStrStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Row informationUser() {
    return Row(
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
                Icon(Icons.location_on_outlined, size: 11, color: Colors.white),
                CustomText(
                    message: 'Adress: 19 Nguyen Huu Tho, District 7, HCMC ',
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(child: Icon(Icons.grid_view_outlined))),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Image.asset(
                  'assets/images/logo.png',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton customFloatingActionButton() {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primaryButton,
      elevation: 2,
      onPressed: () {},
      child: const Icon(
        Icons.location_on_outlined,
        size: 30,
      ),
    );
  }

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        selectedIconTheme: const IconThemeData(
            color: AppColors.primaryButton, opacity: 1, size: 35),
        unselectedIconTheme:
            const IconThemeData(color: AppColors.secondaryText, opacity: 1),
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline), label: 'Report'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Profile'),
        ],
        onTap: (value) {
          onTapHandler(value);
        });
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
