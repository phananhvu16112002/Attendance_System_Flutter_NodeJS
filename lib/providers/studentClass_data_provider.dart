import 'package:attendance_system_nodejs/models/StudentClasses.dart';
import 'package:flutter/material.dart';

class StudentClassesDataProvider with ChangeNotifier {
  List<StudentClasses> _studentClassesList = [];

  List<StudentClasses> get studentClassesList => _studentClassesList;

  void setStudentClassesList(List<StudentClasses> studentClassesList) {
    _studentClassesList = studentClassesList;
    notifyListeners();
  }
}
