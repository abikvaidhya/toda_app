import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';

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
      () => AnimatedNotchBottomBar(
        circleMargin: 0,
        elevation: 0,bottomBarHeight: 80,
        durationInMilliSeconds: 100,
        showBlurBottomBar: false,
        onTap: (i) {
          if (i != 3) appController.homeIndex(i);
          switch (i) {
            case 1:
              appController.homeState(HomeState.search);
              appController.navigateDashboard(id: 1);

              break;
            case 2:
              appController.homeState(HomeState.cart);
              appController.navigateDashboard(id: 2);

              break;
            default:
              appController.homeState(HomeState.home);
              appController.navigateDashboard(id: 0);
              break;
          }
        },
        bottomBarItems: [
          BottomBarItem(
              inActiveItem: Icon(Icons.home_outlined),
              activeItem: Icon(Icons.home_filled),
              itemLabel: 'Home'),
          BottomBarItem(
              inActiveItem: Icon(Icons.search),
              activeItem: Icon(Icons.search),
              itemLabel: 'Search'),
          BottomBarItem(
              inActiveItem: Icon(Icons.shopping_cart_outlined),
              activeItem: Icon(Icons.shopping_cart),
              itemLabel: 'Cart'),
        ],
        kIconSize: 24,
        kBottomRadius: 10,
        notchBottomBarController: appController.navBarController.value,
      ),
    );
  }
}
