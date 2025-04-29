import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/firebase_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/home_screen.dart';

class LoginController extends GetxController {
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  FirebaseController firebaseController = Get.find<FirebaseController>();
  var formKey = GlobalKey<FormState>();
  RxBool processing = false.obs,
      showPassword = false.obs,
      // rememberLogin = false.obs,
      usingEmail = true.obs;

  Rx<TextEditingController> usernameField = TextEditingController().obs,
      passwordField = TextEditingController().obs;

  // checkLogin() async {
  //   rememberLogin((await localStorageHelper.readKey(remember_login)) == 'true');
  // }

  login() async {
    if (formKey.currentState!.validate()) {
      processing(true);

      await firebaseController
          .loginViaEmail(
              email: usernameField.value.text,
              password: passwordField.value.text)
          .then((e) {
        if (e) {
          Get.offAll(() => HomeScreen());
        }
      });
      processing(false);
    }
  }

// rememberMe({required bool check}) {
//   rememberLogin(check);
//   localStorageHelper.write(check.toString(), remember_login);
// }
}
