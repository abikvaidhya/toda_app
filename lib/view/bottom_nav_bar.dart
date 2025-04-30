import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import 'screens/setting_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: appController.homeIndex.value,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
        unselectedFontSize: 14,
        iconSize: 26,
        onTap: (i) {
          if (i != 3) appController.homeIndex(i);
          switch (i) {
            case 1:
              appController.homeState(HomeState.search);
              break;
            case 2:
              appController.homeState(HomeState.cart);
              break;
            case 3:
              Get.to(() => SettingScreen());
              break;
            default:
              appController.homeState(HomeState.home);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
