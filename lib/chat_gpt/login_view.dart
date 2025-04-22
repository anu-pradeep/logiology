import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: (value) => authController.username.value = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) => authController.password.value = value,
            ),
            ElevatedButton(
              onPressed: authController.login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
