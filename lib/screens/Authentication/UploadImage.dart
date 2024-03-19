import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:attendance_system_nodejs/services/CameraScreen.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload Face',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primaryButton),
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => CameraScreen()));
                }, child: selectImage(context)),
                SizedBox(
                  height: 10,
                ),
                selectImage(context),
                const SizedBox(
                  height: 10,
                ),
                selectImage(context),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      color: AppColors.primaryButton,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: CustomText(
                        message: 'Upload Image',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container selectImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 2,
              style: BorderStyle.solid,
              color: AppColors.primaryButton.withOpacity(0.5),
              strokeAlign: BorderSide.strokeAlignInside)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.plus_one_outlined,
                size: 40, color: AppColors.primaryButton),
            CustomText(
                message: 'Add your face',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButton),
          ],
        ),
      ),
    );
  }
}
