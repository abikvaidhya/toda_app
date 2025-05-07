import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/app_drawer.dart';
import 'package:toda_app/view/bottom_nav_bar.dart';
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
  SupabaseController supabaseController =
      Get.put(SupabaseController(), permanent: true);
  ProductController productController =
      Get.put(ProductController(), permanent: true);
  CartController cartController = Get.put(CartController(), permanent: true);

  Widget homeWidgets() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: appController.homePageController,
      children: [
        Dashboard(),
        Search(),
        Cart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomNavBar(),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Toda Mart',
          style: AppThemeData.appThemeData.textTheme.labelLarge!.copyWith(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: primaryColor,
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
      body: RefreshIndicator(
        onRefresh: () async => productController.clearProductCache(),
        child: homeWidgets(),
      ),
    );
  }
}
