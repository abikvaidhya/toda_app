import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/firebase_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/landing_screen.dart';

class AppController extends GetxController {
  FirebaseController firebaseController = Get.find<FirebaseController>();
  Rx<NotchBottomBarController> navBarController =
      NotchBottomBarController().obs;
  Rx<HomeState> homeState = HomeState.home.obs;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  PageController homePageController = PageController(initialPage: 0);
  Rx<User>? appUser;
  RxInt homeIndex = 0.obs;

  @override
  onInit() {
    super.onInit();
    appUser = (currentUser!).obs;
  }

  clearAppStorage() {
    localStorageHelper.deleteAll();
    Get.offAll(() => LandingScreen());
  }

  navigateDashboard({required int id, bool changeNav = false}) {
    if (changeNav) {
      navBarController.value.jumpTo(id);
    }
    homePageController.animateToPage(id,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  User? get currentUser =>
      firebaseController.currentUser; // get current logged in user
}

enum HomeState { home, cart, search }
