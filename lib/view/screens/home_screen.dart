import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/main_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/app_drawer.dart';
import '../cart.dart';
import '../dashboard.dart';
import '../search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    MainController mainController = Get.put(MainController(), permanent: true);

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: BlurryContainer(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          padding: EdgeInsets.zero,
          blur: 4,
          color: Colors.green.withAlpha(50),
          child: IconButton(
              onPressed: () => mainController.homeState(HomeState.home),
              icon: Icon(Icons.search))),
      appBar: AppBar(
        titleTextStyle: AppThemeData.appThemeData.textTheme.bodyMedium!,
        title: Text(
          'Toda Mart',
          style: AppThemeData.appThemeData.textTheme.labelLarge!,
        ),
        actions: [
          GestureDetector(
            onTap: () => scaffoldKey.currentState!.openEndDrawer(),
            child: Image.asset(
              app_logo,
              height: 45,
            ),
          )
        ],
      ),
      endDrawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            scale: 1.2,
            image: AssetImage(
              background_dark_green,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Obx(
              () => Column(
                children: [
                  if (mainController.homeState.value == HomeState.home)
                    Dashboard()
                  else if (mainController.homeState.value == HomeState.search)
                    Search()
                  else
                    Cart()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
