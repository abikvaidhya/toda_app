import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<TextEditingController> emailField = TextEditingController().obs,
      phoneNumberField = TextEditingController().obs,
      oldPasswordField = TextEditingController().obs,
      passwordField = TextEditingController().obs,
      passwordVerifyField = TextEditingController().obs;
}
