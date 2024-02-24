import 'dart:io';

import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:attendance_system_nodejs/providers/attendanceForm_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmartCamera extends StatefulWidget {
  const SmartCamera({super.key});

  @override
  State<SmartCamera> createState() => _SmartCameraState();
}

class _SmartCameraState extends State<SmartCamera> {
  File? _imageTest;

  @override
  Widget build(BuildContext context) {
    final attendanceFormDataProvider =
        Provider.of<AttendanceFormDataProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: SmartFaceCamera(
        imageResolution: ImageResolution.veryHigh,
        showCaptureControl: true,
        showControls: true,
        onCapture: (File? image) async {
          if (image != null) {
            setState(() {
              _imageTest = image;
            });
            await SecureStorage().writeSecureData('image', _imageTest!.path);
            var a = await SecureStorage().readSecureData('image');
            print('Successfully: ${a}');
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => AttendanceFormPage(
                            // attendanceForm: AttendanceForm(
                            //     formID: attendanceFormDataProvider
                            //         .attendanceFormData.formID,
                            //     classes: attendanceFormDataProvider
                            //         .attendanceFormData.classes,
                            //     startTime: attendanceFormDataProvider
                            //         .attendanceFormData.startTime,
                            //     endTime: attendanceFormDataProvider
                            //         .attendanceFormData.endTime,
                            //     dateOpen: attendanceFormDataProvider
                            //         .attendanceFormData.dateOpen,
                            //     status: attendanceFormDataProvider
                            //         .attendanceFormData.status,
                            //     typeAttendance: attendanceFormDataProvider
                            //         .attendanceFormData.typeAttendance,
                            //     location: attendanceFormDataProvider
                            //         .attendanceFormData.location,
                            //     latitude: attendanceFormDataProvider
                            //         .attendanceFormData.latitude,
                            //     longtitude: attendanceFormDataProvider
                            //         .attendanceFormData.longtitude,
                            //     radius: attendanceFormDataProvider
                            //         .attendanceFormData.radius),
                          )),
                  (route) => false);
            }
          }
        },
        onFaceDetected: (face) {},
        showFlashControl: true,
        showCameraLensControl: true,
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
        captureControlIcon: CircleAvatar(
          backgroundColor: const Color(0xff96f0ff).withOpacity(0.5),
          radius: 50,
          child: const Icon(Icons.camera_enhance_outlined,
              size: 30, color: Colors.black),
        ),
        lensControlIcon: const CircleAvatar(
          backgroundColor: Color(0xff96f0ff),
          radius: 35,
          child: Icon(
            Icons.crop_rotate_outlined,
            size: 25,
          ),
        ),
      ),
    );
  }
}
