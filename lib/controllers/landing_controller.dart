import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/login_screen.dart';
import '../service/constants.dart';

class LandingController extends GetxController {
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  RxBool checking = true.obs, isInitialized = false.obs;
  Rx<PageController> landingController = PageController(initialPage: 0).obs;
  UserController userController = Get.put(UserController(), permanent: true);

  checkAppInitialization() async {
    checking(true);
    isInitialized(
        (await localStorageHelper.readKey(app_initialized)) == 'true');

    if (isInitialized.value) {
      userController.checkUserStatus();
    } else {
      checking(false);
    }
  }

  changeLandingPage({required int id}) {
    landingController.value.animateToPage(id,
        duration: Duration(milliseconds: 222), curve: Curves.easeInOut);
  }

  initializeApp() {
    isInitialized(true);

    localStorageHelper.write(isInitialized.value.toString(), app_initialized);
    Get.off(() => LoginScreen());
  }
}
