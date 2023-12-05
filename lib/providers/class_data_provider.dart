import 'package:attendance_system_nodejs/models/Class.dart';
import 'package:attendance_system_nodejs/models/Course.dart';
import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:attendance_system_nodejs/models/Teacher.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:flutter/material.dart';

class ClassDataProvider with ChangeNotifier {
  List<StudentClasses> _studentClassesList = [];

  List<StudentClasses> get studentClassesList => _studentClassesList;

  void setStudentClassesList(List<StudentClasses> studentClassesList) {
    _studentClassesList = studentClassesList;
    notifyListeners();
  }
  // StudentClasses _studentClasses = StudentClasses(
  //     student: '',
  //     classes: Class(
  //         classID: '',
  //         roomNumber: '',
  //         shiftNumber: 0,
  //         startTime: '',
  //         endTime: '',
  //         classType: '',
  //         group: '',
  //         subGroup: '',
  //         teacher: Teacher(
  //             teacherID: '',
  //             teacherName: '',
  //             teacherHashedPassword: '',
  //             teacherEmail: '',
  //             teacherHashedOTP: '',
  //             timeToLiveOTP: '',
  //             accessToken: '',
  //             refreshToken: '',
  //             resetToken: '',
  //             active: false),
  //         course: Course(
  //             courseID: '',
  //             courseName: '',
  //             totalWeeks: 0,
  //             requiredWeeks: 0,
  //             credit: 0)),
  //     presenceTotal: 0,
  //     lateTotal: 0,
  //     absenceTotal: 0);

  // StudentClasses get studentClassData => _studentClasses;

  // void setStudentClassesList(List<StudentClasses> studentClassesList) {
  //   _studentClassesList = studentClassesList;
  //   notifyListeners();
  // }
}
