import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/color.dart';
import '../utils/common_button.dart';
import '../utils/common_textfield.dart';
import '../utils/heading_text.dart';
import 'home_screen.dart';


class LoginPage extends StatelessWidget {
  final LoginAuthController authController = Get.put(LoginAuthController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeadText(heading: 'Login', fontSize: 22,),
              SizedBox(height: 25),
              CustomTextField(
                controller: _usernameController,
                hintText: 'Username',
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.username],
                onChanged: (value) {
                  authController.username.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                onChanged: (value) {
                  authController.password.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CommonElevatedButton(buttonText:'Login',
                  buttonColor: ColorClass.redColor,
                  textColor: ColorClass.whiteColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (authController.login()) {
                      Get.put(UserController());
                      Get.to(() => HomePage());
                    } else {
                      Get.snackbar(
                        'Error',
                        'Invalid username or password',
                        backgroundColor: ColorClass.redColor,
                        colorText: ColorClass.whiteColor,

                      );
                    }
                  }
                },
                fontSize: 16,),

            ],
          ),
        ),
      ),
    );
  }
}