import 'package:get/get.dart';

class LoginAuthController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  bool login() {
    return username.value == 'admin' && password.value == 'Pass@123';
  }
}