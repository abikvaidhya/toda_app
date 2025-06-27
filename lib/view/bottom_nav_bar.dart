import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
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
        color: primaryColor,
        removeMargins: true,
        notchColor: primaryColor,
        durationInMilliSeconds: 100,
        showLabel: false,
        showBlurBottomBar: false,
        itemLabelStyle: AppThemeData.appThemeData.textTheme.bodySmall!
            .copyWith(color: tertiaryColor),
        kIconSize: 24,
        kBottomRadius: 0,
        notchBottomBarController: appController.navBarController.value,
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
            inActiveItem: Icon(
              Icons.home_outlined,
              color: tertiaryColor,
            ),
            activeItem: Icon(Icons.home_filled, color: tertiaryColor),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.search,
              color: tertiaryColor,
            ),
            activeItem: Icon(Icons.search, color: tertiaryColor),
            itemLabel: 'Search',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.shopping_cart_outlined,
              color: tertiaryColor,
            ),
            activeItem: Icon(Icons.shopping_cart, color: tertiaryColor),
            itemLabel: 'Cart',
          ),
        ],
      ),
    );
  }
}
