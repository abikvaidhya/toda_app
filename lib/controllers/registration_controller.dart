import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  RxBool showPassword = false.obs, useEmail = true.obs;

  Rx<TextEditingController> nameField = TextEditingController().obs,
      emailField = TextEditingController().obs,
      phoneNumberField = TextEditingController().obs,
      passwordField = TextEditingController().obs,
      verifyPasswordField = TextEditingController().obs;

  register() async {

  }
}
