import 'dart:io';

import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class SmartCamera extends StatefulWidget {
  const SmartCamera({super.key});

  @override
  State<SmartCamera> createState() => _SmartCameraState();
}

class _SmartCameraState extends State<SmartCamera> {
  File? _imageTest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartFaceCamera(
        onCapture: (File? image) async {
          if (image != null) {
            setState(() {
              _imageTest = image;
            });
            await SecureStorage().writeSecureData('image', _imageTest!.path);
            var a = await SecureStorage().readSecureData('image');
            print('Successfully: ${a}');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (builder) => const AttendanceFormPage()),
                (route) => false);
          }
        },
        showFlashControl: false,
        showCameraLensControl: false,
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
      ),
    );
  }
}
