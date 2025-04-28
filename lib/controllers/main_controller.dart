import 'package:get/get.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/landing_screen.dart';

class MainController extends GetxController {
  Rx<HomeState> homeState = HomeState.home.obs;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();

  clearAppStorage() {
    localStorageHelper.deleteAll();
    Get.offAll(()=> LandingScreen());
  }
}

enum HomeState { home, cart, search }
