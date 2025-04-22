import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;
  var imageFile = Rx<File?>(null);

  void updateUsername(String newUsername) => username.value = newUsername;
  void updatePassword(String newPassword) => password.value = newPassword;

  Future<void> pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }
}
