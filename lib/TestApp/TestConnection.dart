import 'package:attendance_system_nodejs/providers/attendanceForm_data_provider.dart';
import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

class TestConnection extends StatefulWidget {
  const TestConnection({super.key});

  @override
  State<TestConnection> createState() => _TestConnectionState();
}

class _TestConnectionState extends State<TestConnection> {
  @override
  Widget build(BuildContext context) {
    final attendanceFormDataProvider =
        Provider.of<AttendanceFormDataProvider>(context, listen: false);
    final studentDataProvider =
        Provider.of<StudentDataProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Connection'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.black,
            child: Center(
              child: Text(
                '${studentDataProvider.userData.studentID}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
