import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/classes/supabase_class.dart';
import 'package:toda_app/view/general/home_screen.dart';
import 'package:toda_app/view/general/login_screen.dart';
import 'package:toda_app/view/ui_utils.dart';

class UserController extends GetxController {
  final supabaseController = SB.instance;
  Rx<TextEditingController> emailField = TextEditingController().obs,
      phoneNumberField = TextEditingController().obs,
      oldPasswordField = TextEditingController().obs,
      passwordField = TextEditingController().obs,
      passwordVerifyField = TextEditingController().obs;
  RxBool updating = false.obs;

  // fetch authenticated user
  User? get getUser => supabaseController.supabase.client.auth.currentUser;

  // login user
  Future<AuthResponse> login({required String id, required String password}) =>
      supabaseController.supabase.client.auth
          .signInWithPassword(email: id, password: password)
          .catchError((e) {
        throw e.message;
      });

  // logout user
  logoutUser() => supabaseController.supabase.client.auth.signOut();

  // check user session status
  checkUserStatus() {
    supabaseController.supabase.client.auth.onAuthStateChange.listen((AuthState authState) {
      if (authState.session == null) {
        debugPrint('>> User session expired!');
        Get.offAll(() => LoginScreen());
      } else if (authState.session!.isExpired) {
        supabaseController.supabase.client.auth.reauthenticate();
      } else {
        Get.offAll(() => HomeScreen());
      }
    });
  }

  // change user email
  updateUserEmail() async {
    updating(true);
    try {
      await supabaseController.supabase.client.auth
          .updateUser(
        UserAttributes(
          email: emailField.value.text,
        ),
      )
          .catchError((e) => throw e.message);
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

  // change user phone number
  updateUserPhoneNumber() async {
    updating(true);
    try {
      await supabaseController.supabase.client.auth
          .updateUser(
        UserAttributes(
          phone: phoneNumberField.value.text,
        ),
      )
          .catchError((e) => throw e.message);
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
