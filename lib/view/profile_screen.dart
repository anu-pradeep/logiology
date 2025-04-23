import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology/utils/color.dart';
import 'package:logiology/utils/common_button.dart';
import 'package:logiology/utils/heading_text.dart';

import '../controllers/user_controller.dart' show UserController;
import '../utils/custom_textfield_profile.dart';

class ProfilePage extends StatelessWidget {
  final UserController userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorClass.whiteColor,
        title: HeadText(heading: 'Profile', fontSize: 22),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () =>
                    userController.profileImagePath.isEmpty
                        ? CircleAvatar(
                          backgroundColor: ColorClass.greyColor,
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: ColorClass.whiteColor,
                          ),
                        )
                        : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(userController.profileImagePath.value),
                          ),
                        ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt, color: ColorClass.greyColor),
                    label: Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        color: ColorClass.blackColor,
                      ),
                    ),
                    onPressed: () {
                      userController.pickImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorClass.whiteColor,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.photo_library,
                      color: ColorClass.greyColor,
                    ),
                    label: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        color: ColorClass.blackColor,
                      ),
                    ),
                    onPressed: () {
                      userController.pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorClass.whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ProfileTextFormField(
                labelText: 'User name',
                initialValue: userController.username.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },

                onChanged: (value) => userController.updateUsername(value),
              ),

              SizedBox(height: 16),
              ProfileTextFormField(
                obscureText: true,
                labelText: 'Password',
                initialValue: userController.password.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },

                onChanged: (value) => userController.updatePassword(value),
              ),

              SizedBox(height: 30),
              CommonElevatedButton(
                buttonText: 'Save',
                buttonColor: ColorClass.redColor,
                textColor: ColorClass.whiteColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.snackbar(
                      'Success',
                      'Profile updated successfully',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                  }
                },
                fontSize: 13,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
