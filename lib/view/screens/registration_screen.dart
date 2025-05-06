import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/registration_controller.dart';
import 'package:toda_app/view/registration_form.dart';

import '../../service/app_theme_data.dart';
import '../../service/constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        titleTextStyle: AppThemeData.appThemeData.textTheme.labelMedium,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                background_green,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RegistrationForm(),
                ],
              ),
            ),
          )),
      bottomNavigationBar: GestureDetector(
          onTap: () => registrationController.register(),
          child: Container(
              height: 50,
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'REGISTER',
                    style: AppThemeData.appThemeData.textTheme.bodyLarge!
                        .copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ],
              ))),
    );
  }
}
