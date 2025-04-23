import 'package:flutter/material.dart';

import 'color.dart';

class ProfileTextFormField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final bool obscureText;
  final String? Function(String?) validator;
  final Function(String) onChanged;

  const ProfileTextFormField({
    super.key,
    required this.labelText,
    required this.initialValue,
    this.obscureText = false,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,labelStyle: TextStyle(fontFamily: 'PoppinsRegular'),
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
      initialValue: initialValue,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
    );
  }
}