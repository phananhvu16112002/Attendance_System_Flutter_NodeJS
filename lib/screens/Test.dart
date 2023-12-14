import 'dart:io';

import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/screens/Home/AfterAttendance.dart';
import 'package:attendance_system_nodejs/services/API.dart';
import 'package:attendance_system_nodejs/services/NotificationService.dart';
import 'package:attendance_system_nodejs/utils/SecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late NotificationService notificationService;
  XFile? _imageFile; // Change type to XFile
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  TextEditingController studentID = TextEditingController();
  TextEditingController classID = TextEditingController();
  TextEditingController formID = TextEditingController();
  XFile? image;

  @override
  void initState() {
    super.initState();
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
    studentID.dispose();
    classID.dispose();
    formID.dispose();
    super.dispose();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: studentID,
                textInputType: TextInputType.text,
                obscureText: false,
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(null)),
                hintText: 'Student',
                prefixIcon: Icon(null),
                readOnly: false),
            CustomTextField(
                controller: classID,
                textInputType: TextInputType.text,
                obscureText: false,
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(null)),
                hintText: 'Class',
                prefixIcon: Icon(null),
                readOnly: false),
            CustomTextField(
                controller: formID,
                textInputType: TextInputType.text,
                obscureText: false,
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(null)),
                hintText: 'Form',
                prefixIcon: Icon(null),
                readOnly: false),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (builder) => bottomSheet(),
                );
              },
              child: const Text('Click'),
            ),
            _imageFile != null
                ? Image.file(
                    File(_imageFile!.path),
                    width: 100,
                    height: 100,
                  )
                : Container(),
            ElevatedButton(
                onPressed: () async {
                  final check = await API().takeAttendance(
                      studentID.text, classID.text, formID.text, image!);
                  if (check) {
                    print('image $image');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AfterAttendance()));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Failed')));
                  }
                },
                child: Text('Post'))
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        image = pickedFile;
      });
      print('ImageFile: $_imageFile');
      print('ImageFile Path: ${_imageFile!.path}');
      print('ImageFile name: ${_imageFile!.name}');
    }
  }
}
