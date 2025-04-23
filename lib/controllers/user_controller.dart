import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;
  var profileImagePath = ''.obs;

  void updateUsername(String value) => username.value = value;
  void updatePassword(String value) => password.value = value;
  void updateProfileImage(String path) => profileImagePath.value = path;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
    }
  }
}