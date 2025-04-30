import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/app_drawer.dart';
import 'package:toda_app/view/bottom_nav_bar.dart';
import '../../controllers/firebase_controller.dart';
import '../cart.dart';
import '../dashboard.dart';
import '../search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AppController appController = Get.put(AppController(), permanent: true);
  FirebaseController firebaseController = Get.find<FirebaseController>();

  Widget homeWidgets() {
    switch (appController.homeState.value) {
      case HomeState.search:
        return Search();
      case HomeState.cart:
        return Cart();
      default:
        return Dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SupabaseController(), permanent: true);
    Get.put(ProductController(), permanent: true);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.green,
      bottomNavigationBar: BottomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Toda Mart',
          style: AppThemeData.appThemeData.textTheme.labelLarge!.copyWith(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
        actions: [
          GestureDetector(
            onTap: () => scaffoldKey.currentState!.openEndDrawer(),
            onLongPress: () => appController.clearAppStorage(),
            child: Image.asset(app_logo),
          ),
        ],
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: BackdropFilter(
          // filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
          child: Obx(
            () => homeWidgets(),
          ),
        ),
      ),
    );
  }
}
