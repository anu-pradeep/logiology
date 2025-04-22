import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:logiology/chat_gpt/user_profile.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() => controller.imageFile.value != null
                ? CircleAvatar(radius: 50, backgroundImage: FileImage(controller.imageFile.value!))
                : CircleAvatar(radius: 50, child: Icon(Icons.person))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.photo), onPressed: () => controller.pickImage(ImageSource.gallery)),
                IconButton(icon: Icon(Icons.camera), onPressed: () => controller.pickImage(ImageSource.camera)),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: controller.updateUsername,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: controller.updatePassword,
            ),
            SizedBox(height: 20),
            Text('Username: ${controller.username}'),
          ],
        ),
      ),
    );
  }
}
