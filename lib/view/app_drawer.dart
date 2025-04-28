import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/main_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';

import '../service/constants.dart';
import 'screens/login_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  MainController mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Image.asset(
            cover,
            height: 180,
            fit: BoxFit.contain,
          ),
          ListTile(
            onTap: () {
              Get.back();
              mainController.homeState(HomeState.home);
            },
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: AppThemeData.appThemeData.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              mainController.homeState(HomeState.cart);
            },
            leading: Icon(Icons.shopping_cart),
            title: Text(
              'Cart',
              style: AppThemeData.appThemeData.textTheme.bodyMedium,
            ),
          ),
          Spacer(),
          ListTile(
            onTap: () => Get.offAll(() => LoginScreen()),
            onLongPress: () => mainController.clearAppStorage(),
            title: Text(
              'Logout',
              style: AppThemeData.appThemeData.textTheme.bodyMedium,
            ),
            trailing: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
