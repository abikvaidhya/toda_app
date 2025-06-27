import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({super.key});

  @override
  State<ProfileManagementScreen> createState() =>
      _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: AppThemeData.appThemeData.textTheme.labelMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            color: primaryColor,
            child: Stack(
              children: [
                // background image
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            opacity: 0.4,
                            image: AssetImage(
                              background_dark_green,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.sizeOf(context).height - 105,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: (Radius.circular(20)),
                        topLeft: (Radius.circular(20)),
                      ),
                      color: Colors.white70,
                    ),
                    child: Column(
                      spacing: 20,
                      children: [
                        SizedBox.shrink(),
                        Stack(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 90,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 100,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 180,
                                width: 160,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: tertiaryColor,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            color: primaryColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            spacing: 10,
                            children: [
                              Column(
                                children: [
                                  Divider(
                                    endIndent: 40,
                                    indent: 40,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    'Account detail:',
                                    style: AppThemeData
                                        .appThemeData.textTheme.labelMedium,
                                  ),
                                  Divider(
                                    endIndent: 90,
                                    indent: 90,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              // email
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white70,
                                ),
                                child: TextFormField(
                                  controller: userController.emailField.value,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (q) {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Your email',
                                    labelStyle: AppThemeData
                                        .appThemeData.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.alternate_email,
                                      color: Colors.black87,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  validator: (_) {
                                    if (_!.trim().isEmpty) {
                                      return 'Please enter your email';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              // phone number
                              Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white70,
                                ),
                                child: TextFormField(
                                  controller:
                                      userController.phoneNumberField.value,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  onFieldSubmitted: (q) {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Your phone number',
                                    labelStyle: AppThemeData
                                        .appThemeData.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.phone_android,
                                      color: Colors.black87,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  // maxLength: 10,
                                  validator: (_) {
                                    if (_!.trim().isEmpty) {
                                      return 'Please enter your phone number';
                                    } else if (_.length != 10) {
                                      return 'Please enter a valid phone number';
                                    }
                                    {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // password section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            spacing: 10,
                            children: [
                              Column(
                                children: [
                                  Divider(
                                    endIndent: 40,
                                    indent: 40,
                                    color: primaryColor,
                                  ),
                                  Text(
                                    'Password section:',
                                    style: AppThemeData
                                        .appThemeData.textTheme.labelMedium,
                                  ),
                                  Divider(
                                    endIndent: 90,
                                    indent: 90,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              // old password
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white70,
                                ),
                                child: TextFormField(
                                  controller:
                                      userController.oldPasswordField.value,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.visiblePassword,
                                  onFieldSubmitted: (q) {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Old password',
                                    labelStyle: AppThemeData
                                        .appThemeData.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.black87,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  validator: (_) {
                                    if (_!.trim().isEmpty) {
                                      return 'Please enter your old password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              // new password
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white70,
                                ),
                                child: TextFormField(
                                  controller:
                                      userController.passwordField.value,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.visiblePassword,
                                  onFieldSubmitted: (q) {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'New password',
                                    labelStyle: AppThemeData
                                        .appThemeData.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.black87,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  validator: (_) {
                                    if (_!.trim().isEmpty) {
                                      return 'Please enter your new password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              //  verify new password
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white70,
                                ),
                                child: TextFormField(
                                  controller:
                                      userController.passwordVerifyField.value,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  onFieldSubmitted: (q) {},
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Verify your new password',
                                    labelStyle: AppThemeData
                                        .appThemeData.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black87),
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.black87,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.visibility_off,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  validator: (_) {
                                    if (_!.trim().isEmpty) {
                                      return 'Please enter your new password';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            spacing: 10,
                            children: [
                              Divider(
                                endIndent: 40,
                                indent: 40,
                                color: primaryColor,
                              ),
                              ElevatedButton(
                                  style: AppThemeData
                                      .appThemeData.elevatedButtonTheme.style,
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      Icon(
                                        Icons.save,
                                        size: 25,
                                      ),
                                      Text('Save changes',
                                          style: AppThemeData.appThemeData
                                              .textTheme.labelMedium!
                                              .copyWith(color: Colors.white)),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox.shrink(),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
