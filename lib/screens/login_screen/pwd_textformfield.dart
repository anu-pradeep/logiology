import 'package:flutter/material.dart';

import '../../custom_widgets/colors.dart';

class TextFieldPassword extends StatelessWidget {
  final bool iconVisible;
  final TextEditingController controller;
  const TextFieldPassword({
    super.key,
    required this.iconVisible,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool showPass = true;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        obscureText: showPass,
        obscuringCharacter: '.',
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(
            color: CommonColor.textFormTextColor,
            fontSize: 15,
            fontFamily: 'PoppinsMedium',
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
          filled: true,
          fillColor: CommonColor.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(08.0),
            borderSide: BorderSide(color: CommonColor.borderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(08.0),
            borderSide: BorderSide(color: CommonColor.borderColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide(color: CommonColor.borderColor, width: 0.5),
          ),
        ),
      ),
    );
  }
}
