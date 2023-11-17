import 'package:attendance_system_nodejs/common/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.obscureText,
    required this.suffixIcon,
    required this.hintText,
  });

  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final Icon suffixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.normal,
            fontSize: 15),
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(20),
            suffixIcon: suffixIcon,
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide:
                    BorderSide(width: 1, color: AppColors.secondaryText)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderSide:
                    BorderSide(width: 1, color: AppColors.primaryButton))),
      ),
    );
  }
}