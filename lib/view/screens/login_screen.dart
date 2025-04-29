import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/login_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loginController.checkLogin();
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemeData.appThemeData,
      child: Scaffold(
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
                  // logo
                  Center(
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: 250,
                    ),
                  ),

                  // login form
                  LoginForm(),

                  Column(
                    spacing: 10,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                            endIndent: 20,
                            indent: 20,
                          )),
                          Text(
                            'Or login using',
                            style: AppThemeData
                                .appThemeData.textTheme.bodySmall!
                                .copyWith(color: Colors.black54),
                          ),
                          Expanded(
                              child: Divider(
                            endIndent: 20,
                            indent: 20,
                          )),
                        ],
                      ),

                      // gmail login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Obx(
                            () => loginController.usingEmail.value
                                ? GestureDetector(
                                    onTap: () {
                                      loginController.usernameField.value
                                          .clear();
                                      loginController.passwordField.value
                                          .clear();
                                      loginController.usingEmail(false);
                                    },
                                    child: Image.asset(
                                      height: 50,
                                      phone,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      loginController.usernameField.value
                                          .clear();
                                      loginController.passwordField.value
                                          .clear();
                                      loginController.usingEmail(true);
                                    },
                                    child: Image.asset(
                                      height: 50,
                                      email,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                          ),
                          Image.asset(
                            height: 50,
                            gmail_logo,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
            onTap: () => loginController.login(),
            child: Obx(
              () => Container(
                  height: 50,
                  color: Colors.green,
                  child: (loginController.processing.value)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white70,
                          ),
                        )
                      : Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LOGIN',
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                            ),
                            Icon(
                              Icons.login,
                              color: Colors.white70,
                            )
                          ],
                        )),
            )),
      ),
    );
  }
}
