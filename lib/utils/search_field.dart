import 'package:flutter/material.dart';

import 'color.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const CustomSearchField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: ColorClass.textFormTextColor,
            fontSize: 15,
            fontFamily: 'PoppinsRegular',
          ),
          prefixIcon: Icon(Icons.search, color: ColorClass.borderColor),
          filled: true,
          fillColor: ColorClass.whiteColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
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
