import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/login_screen.dart';

import '../service/constants.dart';

class LandingController extends GetxController {
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  RxBool checking = true.obs, isInitialized = false.obs;
  Rx<PageController> landingController = PageController(initialPage: 0).obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   checkAppInitialization();
  // }

  checkAppInitialization() async {
    checking(true);
    isInitialized(
        (await localStorageHelper.readKey(app_initialized)) == 'true');

    if (isInitialized.value) {
      Get.offAll(() => LoginScreen());
    } else {
      checking(false);
    }
  }

  initializeApp() {
    isInitialized(true);

    localStorageHelper.write(isInitialized.value.toString(), app_initialized);
    Get.off(() => LoginScreen());
  }
}
