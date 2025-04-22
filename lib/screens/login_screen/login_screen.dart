import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logiology/custom_widgets/colors.dart';
import 'package:logiology/screens/login_screen/pwd_textformfield.dart';
import '../../custom_widgets/heading.dart';
import '../controller/login_controller.dart';
import 'email_textformfield.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Heading(heading: 'Login')),
              SizedBox(height: 40),
              TextFieldEmail(controller: controller.usernameController),
              SizedBox(height: 20),
              TextFieldPassword(
                iconVisible: true,
                controller: controller.passwordController,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: controller.login,
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Welcome to Home Screen!")));
  }
}
