import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/registration_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/general/login_screen.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  RegistrationController registrationController =
      Get.find<RegistrationController>();
  GlobalKey formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
      child: Obx(
        () => BlurryContainer(
          elevation: 5,
          height: 500,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          borderRadius: BorderRadius.circular(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: [
                Image.asset(
                  man,
                  height: 100,
                ),
                Text(
                  'Account details',
                  style: AppThemeData.appThemeData.textTheme.displaySmall!
                      .copyWith(color: Colors.black54),
                ),
                TextFormField(
                  controller: registrationController.nameField.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: AppThemeData.appThemeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.white70),
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.white70,
                    ),
                  ),
                  validator: (_) {
                    if (_!.trim().isEmpty) {
                      return 'Please enter your full name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: registrationController.nameField.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppThemeData.appThemeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.white70),
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Colors.white70,
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
                TextFormField(
                  controller: registrationController.nameField.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: AppThemeData.appThemeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.white70),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.white70,
                    ),
                  ),
                  validator: (_) {
                    if (_!.trim().isEmpty) {
                      return 'Please enter your phone number';
                    } else if (_.length != 10) {
                      return 'Please enter a valid phone number!';
                    } else {
                      return null;
                    }
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => Get.to(() => LoginScreen()),
                      child: Text(
                        "Login here.",
                        style: AppThemeData.appThemeData.textTheme.bodyMedium!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ],
                ),
                // (registrationController.useEmail.value)?
                //     : PinCodeTextField(
                //         length: 6,
                //         textInputAction: TextInputAction.done,
                //         obscureText: true,
                //         animationType: AnimationType.fade,
                //         pinTheme: PinTheme(
                //           shape: PinCodeFieldShape.box,
                //           borderRadius: BorderRadius.circular(5),
                //           fieldHeight: 50,
                //           fieldWidth: 40,
                //           activeFillColor: Colors.white,
                //         ),
                //         animationDuration: Duration(milliseconds: 200),
                //         controller: registrationController.passwordField.value,
                //         autoDisposeControllers: false,
                //         onCompleted: (v) {},
                //         onChanged: (value) {},
                //         beforeTextPaste: (text) {
                //           return true;
                //         },
                //         appContext: context,
                //       ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
