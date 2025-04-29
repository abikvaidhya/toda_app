import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:toda_app/view/screens/home_screen.dart';
import 'package:toda_app/view/screens/login_screen.dart';
import 'package:toda_app/view/ui_utils.dart';

class FirebaseController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RxBool loading = true.obs;
  Rx<User>? appUser;

  // Rx<String?> token = ''.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   checkUserStatus();
  // }

  Stream<User?> get authenticationChanges => firebaseAuth
      .authStateChanges(); // check for authentication changes and return user

  User? get currentUser =>
      firebaseAuth.currentUser; // get current logged in user

  // getToken() async {
  //   token(await FirebaseAppCheck.instance.getToken());
  //   debugPrint('>> got token: ${token.value}');
  // }

  checkUserStatus() async {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('>> User is currently signed out!');
        Get.offAll(() => LoginScreen());
      } else {
        debugPrint('>> User is signed in! ${user.email}');
        appUser = user.obs;
        Get.offAll(() => HomeScreen());
      }
    });
  }

  Future<bool> loginViaEmail(
      {required String email, required String password}) async {
    loading(true);
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((e) {
        debugPrint('>> login successful\n>> saving user');
        UiUtils().showSnackBar(
          title: 'Welcome!',
          message: 'Hello ${e.user!.displayName ?? 'user'}',
          // isError: true,
        );
      }).catchError((e) {
        throw e;
      });
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('Error logging in using mail and password: ${e.message}');
      UiUtils().showSnackBar(
        title: 'Error',
        message: e.message.toString(),
        isError: true,
      );
      return false;
    } finally {
      loading(false);
    }
  }

  loginViaGmail() async {
    loading(true);
    try {
      // await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error logging in using Gmail: $e');
    } finally {
      loading(false);
    }
  }

  Future<bool> createAccountViaEmail(
      {required String email, required String password}) async {
    loading(true);
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((e) {
        debugPrint(
            '>> account creation successful\n>> logging in with the account');
        // appUser(e.user);
        return true;
      }).catchError((e) {
        throw e;
      });
    } catch (e) {
      debugPrint('Error signing in using email and password: $e');
    } finally {
      loading(false);
    }
    return false;
  }

  updateAccount() async {
    loading(true);
    try {} catch (e) {
      debugPrint('Error updating account: $e');
    } finally {
      loading(false);
    }
  }

  logOut() async {
    await firebaseAuth.signOut();
    Get.offAll(() => LoginScreen());
  }
}
