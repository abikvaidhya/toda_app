import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controllers/login_controller.dart';
import '../service/app_theme_data.dart';
import 'screens/registration_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
      child: Obx(
        () => Form(
          key: loginController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              BlurryContainer(
                elevation: 5,
                blur: 8,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  controller: loginController.usernameField.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: (loginController.usingEmail.value)
                        ? 'Email'
                        : 'Phone Number',
                    labelStyle: AppThemeData.appThemeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.black87),
                    prefixIcon: Icon(
                      (loginController.usingEmail.value)
                          ? Icons.alternate_email
                          : Icons.phone,
                      color: Colors.black87,
                    ),
                  ),
                  validator: (_) {
                    if (_!.trim().isEmpty) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(_)) {
                      return 'Please enter a valid email!';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              BlurryContainer(
                elevation: 5,
                blur: 8,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                borderRadius: BorderRadius.circular(10),
                child: (loginController.usingEmail.value)
                    ? TextFormField(
                        controller: loginController.passwordField.value,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !loginController.showPassword.value,
                        onFieldSubmitted: (_) => loginController.login(),
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(color: Colors.black87),
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.black87,
                            ),
                            suffix: IconButton(
                              onPressed: () => loginController.showPassword(
                                  !loginController.showPassword.value),
                              icon: Obx(
                                () => Icon((loginController.showPassword.value)
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off),
                              ),
                              color: Colors.black87,
                            )),
                        validator: (_) {
                          if (_!.trim().isEmpty) {
                            return 'Please enter your password';
                          } else if (_.length < 8) {
                            return 'Please enter a valid password!';
                          } else {
                            return null;
                          }
                        },
                      )
                    : PinCodeTextField(
                        length: 6,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.black87,
                        ),
                        animationDuration: Duration(milliseconds: 200),
                        controller: loginController.passwordField.value,
                        autoDisposeControllers: false,
                        onCompleted: (v) {},
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Checkbox(
                  //       value: loginController.rememberLogin.value,
                  //       onChanged: (v) => loginController.rememberMe(
                  //           check: !loginController.rememberLogin.value),
                  //       activeColor: Colors.green,
                  //     ),
                  //     Text('Remember me.'),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () => Get.to(() => RegistrationScreen()),
                        child: Text(
                          "Register here.",
                          style: AppThemeData.appThemeData.textTheme.bodyMedium!
                              .copyWith(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
