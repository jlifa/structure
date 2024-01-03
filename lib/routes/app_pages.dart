import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:structure_project/app/modules/login/binding/login_binding.dart';
import 'package:structure_project/app/modules/login/view/login_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FIRST_SCREEN;

  static final routes = [
    GetPage(name: '/', page: () => const LoginView(),binding: LoginBinding()),

  ];
}
