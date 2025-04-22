import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: AppPages.routes,
  ));
}
