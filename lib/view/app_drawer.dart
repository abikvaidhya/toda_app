import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/firebase_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import '../service/constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AppController mainController = Get.find<AppController>();
  FirebaseController firebaseController = Get.find<FirebaseController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  cover,
                  height: 180,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Get.back();
                mainController.homeState(HomeState.cart);
              },
              leading: Icon(
                Icons.receipt_long,
              ),
              title: Text(
                'Orders',
                style: AppThemeData.appThemeData.textTheme.bodyLarge,
              ),
            ),
            Spacer(),
            ListTile(
              onTap: () => firebaseController.logOut(),
              onLongPress: () => mainController.clearAppStorage(),
              title: Text(
                'Logout',
                style: AppThemeData.appThemeData.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
