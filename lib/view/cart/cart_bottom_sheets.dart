import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';

class CartBottomSheet{

  deleteCartConfirmationBottomSheet() {
    CartController cartController = Get.find<CartController>();

    return Get.bottomSheet(
      elevation: 5,
      backgroundColor: Colors.white,
      IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 50,
                    color: errorColor,
                  )),
              Column(
                spacing: 10,
                children: [
                  Text(
                    'Are you sure you want to clear the products from your cart?',
                    style: AppThemeData.appThemeData.textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Once the cart is cleared, you will have to add products manually again once you clear the products.',
                    style: AppThemeData.appThemeData.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: AppThemeData.appThemeData.elevatedButtonTheme.style!
                        .copyWith(
                        backgroundColor:
                        WidgetStateProperty.all<Color>(errorColor)),
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: AppThemeData.appThemeData.textTheme.labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await cartController.clearCart();
                      Get.back();
                      Get.find<AppController>()
                          .navigateDashboard(id: 0, changeNav: true);
                    },
                    child: Text(
                      'Confirm',
                      style: AppThemeData.appThemeData.textTheme.labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox.shrink()
            ],
          ),
        ),
      ),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      enableDrag: true,
    );
  }
  cartUI({required int activeStep}) {
    return EasyStepper(
        activeStep: activeStep,
        stepShape: StepShape.rRectangle,
        stepBorderRadius: 10,
        borderThickness: 1,
        padding: EdgeInsets.all(20),
        stepRadius: 25,
        finishedStepBorderColor: Colors.deepOrange,
        finishedStepTextColor: Colors.deepOrange,
        finishedStepBackgroundColor: Colors.deepOrange,
        activeStepIconColor: Colors.deepOrange,
        showLoadingAnimation: false,
        steps: [
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: activeStep >= 0 ? 1 : 0.3,
                child: Icon(Icons.shopping_cart_checkout),
              ),
            ),
            customTitle: const Text(
              'Checkout',
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: activeStep >= 1 ? 1 : 0.3,
                child: Icon(Icons.local_shipping),
              ),
            ),
            customTitle: const Text(
              'Order Detail',
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Opacity(
                opacity: activeStep >= 2 ? 1 : 0.3,
                child: Icon(Icons.done_all),
              ),
            ),
            customTitle: const Text(
              'Complete',
              textAlign: TextAlign.center,
            ),
          ),
        ],
        onStepReached: (index) => activeStep = index);
  }
}