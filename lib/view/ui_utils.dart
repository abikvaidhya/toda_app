import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiUtils {
  showSnackBar(
      {required String title,
      required String message,
      bool isError = false,
      bool isLong = false}) {
    Get.showSnackbar(GetSnackBar(
      showProgressIndicator: true,
      backgroundColor: isError ? Colors.red : Colors.green,
      snackStyle: SnackStyle.GROUNDED,
      duration: Duration(seconds: isLong ? 5 : 3),
      icon: isError ? Icon(Icons.error) : null,
      title: title,
      message: message,
      barBlur: 1,
    ));
    ;
  }
}
