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
}
