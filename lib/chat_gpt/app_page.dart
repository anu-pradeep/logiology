import 'package:get/get.dart';
import 'package:logiology/chat_gpt/profile_view.dart';

import 'home.dart';
import 'login_view.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/profile', page: () => ProfileView()),
  ];
}
