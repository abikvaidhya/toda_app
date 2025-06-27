import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/screens/orders/order_history_screen.dart';
import 'package:toda_app/view/screens/settings/profile_management_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  AppController mainController = Get.find<AppController>();

  UserController userController = Get.find<UserController>();

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
              onTap: () => Get.to(() => OrderHistoryScreen()),
              leading: Icon(
                Icons.receipt_long,
              ),
              title: Text(
                'Order History',
                style: AppThemeData.appThemeData.textTheme.bodyLarge,
              ),
            ),
            Spacer(),
            ListTile(
              leading: GestureDetector(
                  onTap: () => Get.to(() => ProfileManagementScreen()),
                  child: Icon(Icons.account_circle)),
              trailing: GestureDetector(
                  onTap: () => userController.logoutUser(),
                  child: Icon(Icons.logout)),
            ),
          ],
        ),
      ),
    );
  }
}
