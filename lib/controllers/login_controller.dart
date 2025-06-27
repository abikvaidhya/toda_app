import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/general/home_screen.dart';
import 'package:toda_app/view/ui_utils.dart';

// admin.toda@gmail.com
// poiu0987

// abik.vaidhya@gmail.com
// qwerqwer

class LoginController extends GetxController {
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  UserController userController = Get.find<UserController>();

  var loginFormKey = GlobalKey<FormState>();
  RxBool processing = false.obs, showPassword = false.obs

      // usingEmail = true.obs
      ;

  Rx<TextEditingController> usernameField = TextEditingController().obs,
      passwordField = TextEditingController().obs;

  login() async {
    if (loginFormKey.currentState!.validate()) {
      debugPrint('>> ${usernameField.value.text}');
      debugPrint('>> ${passwordField.value.text}');

      processing(true);

      await userController
          .login(
              id: usernameField.value.text, password: passwordField.value.text)
          .then((e) {
        if (e.session != null && e.user != null) {
          Get.offAll(() => HomeScreen());
        }
      }).catchError((e) {
        debugPrint('>> error logging in: ${e.toString()}');
        UiUtils().showSnackBar(
            title: 'Error logging in', message: e.toString(), isError: true);
      });
      processing(false);
    }
  }
}
