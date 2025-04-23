import 'package:flutter/material.dart';

import 'color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final List<String>? autofillHints;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: TextInputAction.next,
        autofillHints: autofillHints,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: ColorClass.textFormTextColor,
            fontSize: 15,
            fontFamily: 'PoppinsRegular',
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          filled: true,
          fillColor: ColorClass.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(08.0),
            borderSide: BorderSide(color: ColorClass.borderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(08.0),
            borderSide: BorderSide(color: ColorClass.borderColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(08.0),
            borderSide: BorderSide(color: ColorClass.borderColor, width: 0.5),
          ),
        ),
      ),
    );
  }
}