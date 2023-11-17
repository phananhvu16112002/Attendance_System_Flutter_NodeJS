import 'package:attendance_system_nodejs/Pages/CreateNewPassword/components/body_CreateNewPassword.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String description =
      'Your new password must be unique from those previously used';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyCreateNewPassword(description: description, password: password),
    );
  }
}
