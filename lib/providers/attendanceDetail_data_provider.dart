import 'package:attendance_system_nodejs/models/AttendanceDetail.dart';
import 'package:flutter/material.dart';

class AttendanceDetailDataProvider with ChangeNotifier {
  List<AttendanceDetail> _attendanceDetailList = [];

  List<AttendanceDetail> get attendanceDetailData => _attendanceDetailList;

  void setAttendanceDetailList(List<AttendanceDetail> attendanceDetailList) {
    _attendanceDetailList = attendanceDetailList;
    notifyListeners();
  }
}
