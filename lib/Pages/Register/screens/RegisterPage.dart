import 'package:attendance_system_nodejs/Pages/Register/components/Body.dart';
import 'package:attendance_system_nodejs/Pages/SignIn/components/Body.dart';
import 'package:attendance_system_nodejs/Pages/SignIn/screens/SignInPage.dart';
import 'package:attendance_system_nodejs/common/bases/CustomButton.dart';
import 'package:attendance_system_nodejs/common/bases/CustomText.dart';
import 'package:attendance_system_nodejs/common/bases/CustomTextField.dart';
import 'package:attendance_system_nodejs/common/bases/ImageSlider.dart';
import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyRegister(
          username: username,
          emailAddress: emailAddress,
          password: password,
          confirmPassword: confirmPassword),
    );
  }
}
