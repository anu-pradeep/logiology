import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/custom_widgets/colors.dart';

import '../login_screen/login_screen.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username == "admin" && password == "Pass@123") {
      Get.off(() => HomeScreen());
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid username or password",
        backgroundColor: CommonColor.redColor.withOpacity(0.8),
        colorText: CommonColor.whiteColor,
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
