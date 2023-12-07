import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/providers/studentClass_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class customAppBar extends StatelessWidget {
  const customAppBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
}
