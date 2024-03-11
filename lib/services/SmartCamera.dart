import 'dart:io';

import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/models/AttendanceForm.dart';
import 'package:attendance_system_nodejs/providers/attendanceForm_data_provider.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPage.dart';
import 'package:attendance_system_nodejs/screens/Home/AttendanceFormPageQR.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SmartCamera extends StatefulWidget {
  const SmartCamera({super.key, required this.checkQR});
  final bool checkQR;

  @override
  State<SmartCamera> createState() => _SmartCameraState();
}

class _SmartCameraState extends State<SmartCamera> {
  File? _imageTest;
  late Box<AttendanceForm> boxAttendanceForm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openCamera();
    openBox();
  }


  Future<void> openCamera() async {
    await FaceCamera.initialize();
    print('ákdasjdlasjdlkasjdskas');
  }

  Future<void> openBox() async {
    await Hive.initFlutter();
    boxAttendanceForm = await Hive.openBox<AttendanceForm>('attendanceFormBox');
  }

  @override
  Widget build(BuildContext context) {
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
              if (widget.checkQR != true) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AttendanceFormPage()),
                    (route) => false);
              } else {
                AttendanceForm? attendanceForm =
                    boxAttendanceForm.get('AttendanceFormTemp');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AttendanceFormPageQR(
                              attendanceForm: attendanceForm!,
                            )),
                    (route) => false);
              }
            }
          }
        },
        onFaceDetected: (face) {},
        messageBuilder: (context, face) {
          if (face == null) {
            return _message('Place your face in the camera');
          }
          if (!face.wellPositioned) {
            return _message('Center your face in the square');
          }
          return const SizedBox.shrink();
        },
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

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
