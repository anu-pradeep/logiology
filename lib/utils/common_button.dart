import 'package:flutter/material.dart';

class CommonElevatedButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPressed;
  const CommonElevatedButton(
      {super.key,
        required this.buttonText,
        required this.buttonColor,
        required this.textColor,
        required this.onPressed,
        required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(08),
            ),
            backgroundColor: buttonColor,
            fixedSize: const Size(130, 30)),
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontFamily: 'PoppinsMedium',
              fontSize: fontSize),
        ));
  }
}
