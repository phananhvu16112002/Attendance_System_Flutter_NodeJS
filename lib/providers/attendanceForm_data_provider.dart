import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:flutter/material.dart';

class AttendanceFormDataProvider with ChangeNotifier {
  late AttendanceForm _attendanceFormData;

  AttendanceForm get attendanceFormData => _attendanceFormData;

  void setAttendanceFormData(AttendanceForm attendanceForm) {
    _attendanceFormData = attendanceForm;
    notifyListeners();
  }
}
