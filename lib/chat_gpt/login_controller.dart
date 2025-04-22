import 'package:get/get.dart';

class AuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  void login() {
    if (username.value == 'admin' && password.value == 'Pass@123') {
      Get.offNamed('/home');
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }
  }
}
