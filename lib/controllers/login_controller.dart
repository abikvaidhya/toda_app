import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toda_app/view/screens/home_screen.dart';

class LoginController extends GetxController {
  RxBool showPassword = false.obs,
      rememberLogin = false.obs,
      formFocused = false.obs,
      usingEmail = true.obs;

  Rx<TextEditingController> usernameField = TextEditingController().obs,
      passwordField = TextEditingController().obs;

  login() {
    Get.offAll(() => HomeScreen());
  }
}
