import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/landing_controller.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: (landingController.checking.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : PageView(
                children: [
                  CustomPaint(
                    painter: CustomCurvePaintFirst(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              logo,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                            Text('Join us',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelLarge!),
                          ],
                        ),
                        Column(
                          spacing: 20,
                          children: [
                            Text('Register on our platform for easy shopping!',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall!
                                    .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal)),
                            CircleAvatar(
                                backgroundColor: Colors.black26,
                                child: Icon(Icons.navigate_next,
                                    color: Colors.green)),
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                  CustomPaint(
                    painter: CustomCurvePaintSecond(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              logo,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                            Text('Browse our products online',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelLarge!),
                          ],
                        ),
                        Column(
                          spacing: 10,
                          children: [
                            Text('View all the products that we sell.',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall!
                                    .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal)),
                            CircleAvatar(
                                backgroundColor: Colors.black26,
                                child: Icon(Icons.navigate_next,
                                    color: Colors.green))
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                  CustomPaint(
                    painter: CustomCurvePaintLast(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              logo,
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                            Text('Offers and sales!',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelLarge!),
                          ],
                        ),
                        Column(
                          spacing: 10,
                          children: [
                            Text(
                              'Get exclusive offers and be the first to know regarding the any offers we provide.',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelSmall!
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            ElevatedButton(
                                onPressed: () =>
                                    landingController.initializeApp(),
                                child: Icon(
                                  Icons.login,
                                  color: Colors.green,
                                  size: 30,
                                )),
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ));
  }
}
