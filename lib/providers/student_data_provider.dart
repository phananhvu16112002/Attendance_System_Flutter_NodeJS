import 'package:attendance_system_nodejs/models/User.dart';
import 'package:flutter/material.dart';

class StudentDataProvider with ChangeNotifier {
  Student _student = Student(
      studentID: '',
      studentName: '',
      studentEmail: '',
      password: '',
      accessToken: '',
      refreshToken: '',
      active: false);

  Student get userData => _student;

  void setStudentName(String userName) {
    _student.studentName = userName;
    notifyListeners();
  }

  void setStudentID(String studentID) {
    _student.studentID = studentID;
    notifyListeners();
  }

  void setStudentEmail(String studentEmail) {
    _student.studentEmail = studentEmail;
    notifyListeners();
  }

  void setPassword(String password) {
    _student.password = password;
    notifyListeners();
  }

  void setAccessToken(String accessToken) {
    _student.accessToken = accessToken;
    notifyListeners();
  }

  void setRefreshToken(String refreshToken) {
    _student.refreshToken = refreshToken;
    notifyListeners();
  }

  void setActive(bool active) {
    _student.active = active;
    notifyListeners();
  }

  void setUserData(Student data) {
    _student = data;
    notifyListeners();
  }
}
