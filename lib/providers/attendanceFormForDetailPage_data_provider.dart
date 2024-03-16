import 'package:attendance_system_nodejs/models/ModelForAPI/AttendanceFormForDetailPage.dart';
import 'package:attendance_system_nodejs/models/ModelForAPI/ClassForDetailPage.dart';
import 'package:attendance_system_nodejs/models/ModelForAPI/CourseForDetailPage.dart';
import 'package:flutter/material.dart';

class AttendanceFormDataForDetailPageProvider with ChangeNotifier {
  AttendanceFormForDetailPage _attendanceFormDataForDetailPage =
      AttendanceFormForDetailPage(
          formID: '',
          startTime: '',
          endTime: '',
          status: false,
          type: 0,
          classes: Classes(
              roomNumber: '',
              shiftNumber: 0,
              startTime: '',
              endTime: '',
              classType: '',
              group: '',
              subGroup: '',
              course: Course(courseID: '', courseName: '')), dateOpen: '');

  AttendanceFormForDetailPage get attendanceFormData =>
      _attendanceFormDataForDetailPage;

  void setAttendanceFormData(AttendanceFormForDetailPage attendanceForm) {
    if (attendanceForm.formID == '') {
      print('Update AttendanceForm Provider Failed');
    } else {
      _attendanceFormDataForDetailPage = attendanceForm;
      notifyListeners();
      print('Update successfully');
    }
  }
}
