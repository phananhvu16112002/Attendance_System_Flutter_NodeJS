import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.backgroundColorButton,
    required this.borderColor,
    required this.textColor,
  });

  final String buttonName;
  final Color backgroundColorButton;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      width: 400,
      decoration: BoxDecoration(
          color: backgroundColorButton,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 1, color: borderColor)),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
