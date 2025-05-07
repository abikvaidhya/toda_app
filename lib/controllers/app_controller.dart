import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/landing_screen.dart';

class AppController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  Rx<NotchBottomBarController> navBarController =
      NotchBottomBarController(index: 0).obs;
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

  User? get currentUser =>
      supabaseController.getUser; // get current logged in user
  navigateDashboard({required int id, bool changeNav = false}) {
    if (changeNav) {
      navBarController.value.jumpTo(id);
    }
    homePageController.animateToPage(id,
        duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  clearAppStorage() {
    localStorageHelper.deleteAll();
    Get.offAll(() => LandingScreen());
  }
}

enum HomeState { home, cart, search }
