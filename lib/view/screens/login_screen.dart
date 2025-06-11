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
                opacity: 0.1),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Center(
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      color: primaryColor,
                      height: 220,
                    ),
                  ),

                  // login form
                  LoginForm(),

                  // login button
                  GestureDetector(
                      onTap: () => loginController.login(),
                      child: Obx(
                        () => Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 60,
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

                  // login without email and password section
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Column(
                  //     spacing: 10,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Expanded(
                  //               child: Divider(
                  //             endIndent: 20,
                  //             indent: 20,
                  //             color: Colors.black54,
                  //           )),
                  //           Text(
                  //             'Or continue with',
                  //             style: AppThemeData
                  //                 .appThemeData.textTheme.labelSmall!
                  //                 .copyWith(color: Colors.black54),
                  //           ),
                  //           Expanded(
                  //               child: Divider(
                  //             endIndent: 20,
                  //             indent: 20,
                  //             color: Colors.black54,
                  //           )),
                  //         ],
                  //       ), // gmail login
                  //       BlurryContainer(
                  //         elevation: 5,
                  //         blur: 8,
                  //         height: 60,
                  //         color: Colors.black12,
                  //         padding: EdgeInsets.symmetric(horizontal: 20),
                  //         borderRadius: BorderRadius.circular(30),
                  //         child: Obx(
                  //           () => loginController.usingEmail.value
                  //               ? GestureDetector(
                  //                   onTap: () {
                  //                     loginController.usernameField.value
                  //                         .clear();
                  //                     loginController.passwordField.value
                  //                         .clear();
                  //                     loginController.usingEmail(false);
                  //                   },
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     spacing: 20,
                  //                     children: [
                  //                       Image.asset(
                  //                         height: 30,
                  //                         phone,
                  //                         fit: BoxFit.contain,
                  //                       ),
                  //                       Text('Login using email')
                  //                     ],
                  //                   ),
                  //                 )
                  //               : GestureDetector(
                  //                   onTap: () {
                  //                     loginController.usernameField.value
                  //                         .clear();
                  //                     loginController.passwordField.value
                  //                         .clear();
                  //                     loginController.usingEmail(true);
                  //                   },
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     spacing: 20,
                  //                     children: [
                  //                       Image.asset(
                  //                         height: 30,
                  //                         email,
                  //                         fit: BoxFit.contain,
                  //                       ),
                  //                       Text('Login using phone')
                  //                     ],
                  //                   ),
                  //                 ),
                  //         ),
                  //       ),
                  //       BlurryContainer(
                  //         elevation: 5,
                  //         blur: 8,
                  //         height: 60,
                  //         color: Colors.black12,
                  //         padding: EdgeInsets.symmetric(horizontal: 20),
                  //         borderRadius: BorderRadius.circular(30),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           spacing: 20,
                  //           children: [
                  //             Image.asset(
                  //               height: 30,
                  //               gmail_logo,
                  //               fit: BoxFit.contain,
                  //             ),
                  //             Text('Login using Gmail')
                  //           ],
                  //         ),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text("Don't have an account? "),
                  //           GestureDetector(
                  //             onTap: () => Get.to(() => RegistrationScreen(),
                  //                 transition: Transition.cupertino),
                  //             child: Text(
                  //               "Register here.",
                  //               style: AppThemeData
                  //                   .appThemeData.textTheme.bodyMedium!
                  //                   .copyWith(color: primaryColor),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
