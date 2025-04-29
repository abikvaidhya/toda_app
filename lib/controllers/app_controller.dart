import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/firebase_controller.dart';
import 'package:toda_app/service/local_storage_helper.dart';
import 'package:toda_app/view/screens/landing_screen.dart';

class AppController extends GetxController {
  FirebaseController firebaseController = Get.find<FirebaseController>();
  Rx<HomeState> homeState = HomeState.home.obs;
  LocalStorageHelper localStorageHelper = LocalStorageHelper();
  Rx<User>? appUser;

  @override
  onInit() {
    super.onInit();
    appUser = (currentUser!).obs;
  }

  clearAppStorage() {
    localStorageHelper.deleteAll();
    Get.offAll(() => LandingScreen());
  }

  User? get currentUser =>
      firebaseController.currentUser; // get current logged in user
}

enum HomeState { home, cart, search }
