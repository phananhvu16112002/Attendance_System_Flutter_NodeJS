import 'package:attendance_system_nodejs/Pages/NewPassword/components/BodyNewPassword.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyNewPassword(newPassword: newPassword, confirmPassword: confirmPassword));
  }
}