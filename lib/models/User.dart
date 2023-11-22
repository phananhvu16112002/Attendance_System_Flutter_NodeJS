import 'package:flutter/material.dart';

class Student {
  String studentID = '';
  String studentName = '';
  String studentEmail = '';
  String password = '';
  String accessToken = '';
  String refreshToken = '';
  bool active = false;

  Student({
    required this.studentID,
    required this.studentName,
    required this.studentEmail,
    required this.password,
    required this.accessToken,
    required this.refreshToken,
    required this.active,
  });
}
