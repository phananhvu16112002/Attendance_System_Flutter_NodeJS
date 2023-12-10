import 'dart:io';

import 'package:attendance_system_nodejs/services/NotificationService.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  const Test({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late NotificationService notificationService;
  XFile? _imageFile; // Change type to XFile
  final ImagePicker _picker = ImagePicker();
  XFile? file;

  @override
  void initState() {
    super.initState();
    getValue();
  }

  Future<void> getValue() async {
    var value = await SecureStorage().readSecureData('image');
    print(value);
    setState(() {
      file = XFile(value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    file;
    _imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) => bottomSheet(),
                );
              },
              child: const Text('Click'),
            ),
            file != null
                ? Image.file(File(file!.path))
                : Image.asset('assets/images/logo.png'),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Your Photo',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
      print('ImageFile: $_imageFile');
      print('ImageFile Path: ${_imageFile!.path}');
      print('ImageFile name: ${_imageFile!.name}');
    }
  }
}
