import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/view/ui_utils.dart';

class UserController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  Rx<TextEditingController> emailField = TextEditingController().obs,
      phoneNumberField = TextEditingController().obs,
      oldPasswordField = TextEditingController().obs,
      passwordField = TextEditingController().obs,
      passwordVerifyField = TextEditingController().obs;
  RxBool updating = false.obs;

  updateUserEmail() async {
    updating(true);
    try {
      await supabaseController.updateUserEmail(email: emailField.value.text);
    } catch (e) {
      debugPrint('>> error updating user email: $e');
      UiUtils().showSnackBar(
        title: 'Error updating profile!',
        message: 'Could not update email at the moment!',
        isError: true,
      );
    } finally {
      updating(false);
    }
  }

  updateUserPhoneNumber() async {
    updating(true);
    try {
      await supabaseController.updateUserPhone(
          phoneNumber: phoneNumberField.value.text);
    } catch (e) {
      debugPrint('>> error updating user phone number: $e');
      UiUtils().showSnackBar(
        title: 'Error updating profile!',
        message: 'Could not update phone number at the moment!',
        isError: true,
      );
    } finally {
      updating(false);
    }
  }
}
