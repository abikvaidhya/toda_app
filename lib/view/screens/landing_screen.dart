import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/landing_controller.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/curved_containers.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  LandingController landingController = Get.put(LandingController());

  @override
  void initState() {
    super.initState();
    landingController.checkAppInitialization();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<LandingController>(); // delete controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => (landingController.checking.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : CustomPaint(
                painter: CustomCurvePaintFirst(),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            logo,
                            height: 350,
                            fit: BoxFit.contain,
                            // color: primaryColor,
                          ),
                          Text('Join our mobile app',
                              style: AppThemeData
                                  .appThemeData.textTheme.displaySmall!
                                  .copyWith(color: primaryColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: landingController.landingController.value,
                        children: [
                          landingPage(id: 1),
                          landingPage(id: 2),
                          landingPage(id: 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }

  Widget landingPage({required int id}) {
    switch (id) {
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            SizedBox(
              height: 40,
            ),
            Text('Register on our platform for easy shopping!',
                textAlign: TextAlign.center,
                style: AppThemeData.appThemeData.textTheme.labelMedium!
                    .copyWith(
                        color: Colors.black54, fontWeight: FontWeight.normal)),
            GestureDetector(
              onTap: () => landingController.changeLandingPage(id: 1),
              child: CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.navigate_next, color: primaryColor)),
            ),
            SizedBox()
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            Text('View all the products that we sell.',
                style: AppThemeData.appThemeData.textTheme.labelMedium!
                    .copyWith(
                        color: Colors.black54, fontWeight: FontWeight.normal)),
            GestureDetector(
              onTap: () => landingController.changeLandingPage(id: 2),
              child: CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Icon(Icons.navigate_next, color: primaryColor)),
            ),
            SizedBox()
          ],
        );
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 20,
          children: [
            Text(
              'Get exclusive offers and be the first to know regarding the any offers we provide.',
              style: AppThemeData.appThemeData.textTheme.labelMedium!.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => landingController.initializeApp(),
              child: Icon(
                Icons.login,
                // color: primaryColor,
                size: 25,
              ),
            ),
            SizedBox()
          ],
        );
    }
  }
}
