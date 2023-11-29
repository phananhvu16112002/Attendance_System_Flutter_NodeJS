import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.backgroundColorButton,
    required this.borderColor,
    required this.textColor,
    required this.function,
    required this.height,
    required this.width,
    required this.fontSize,
  });

  final String buttonName;
  final Color backgroundColorButton;
  final Color borderColor;
  final Color textColor;
  final void Function()? function;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColorButton,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(width: 1, color: borderColor)),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
