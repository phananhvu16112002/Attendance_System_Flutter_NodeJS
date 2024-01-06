import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/models/Class.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:flutter/material.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    print(time);
    return Scaffold(
      body: Center(child: Text('$time')),
    );
  }
}
