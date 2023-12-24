import 'package:attendance_system_nodejs/providers/student_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentDataProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider.userData.latitude.toString()),
            Text(provider.userData.longtitude.toString()),
            Text(provider.userData.location)
          ],
        ),
      ),
    );
  }
}
