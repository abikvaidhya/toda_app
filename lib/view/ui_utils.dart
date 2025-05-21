import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';

import '../controllers/cart_controller.dart';
import '../service/app_theme_data.dart';
import '../service/constants.dart';

class UiUtils {
  showSnackBar(
      {required String title,
      required String message,
      bool isError = false,
      bool isLong = false}) {
    Get.showSnackbar(GetSnackBar(
      showProgressIndicator: true,
      backgroundColor: isError ? Colors.red : primaryColor,
      snackStyle: SnackStyle.GROUNDED,
      duration: Duration(seconds: isLong ? 5 : 3),
      icon: isError ? Icon(Icons.error) : null,
      title: title,
      message: message,
      barBlur: 1,
    ));
  }

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

  orderConfirmationBottomSheet({required String phoneNumber}) {
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
                Icons.shopping_bag_outlined,
                size: 50,
                color: primaryColor,
              )),
              Column(
                spacing: 10,
                children: [
                  Text(
                    'Confirm your order?',
                    style: AppThemeData.appThemeData.textTheme.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Are you sure you want to place your order?',
                    style: AppThemeData.appThemeData.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Obx(
                () => (cartController.processingOrder.value)
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: AppThemeData
                                .appThemeData.elevatedButtonTheme.style!
                                .copyWith(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            errorColor)),
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              await cartController.placeOrder();
                              if (cartController.orderPlaced.value) {
                                orderConfirmedBottomSheet();
                              }
                            },
                            child: Text(
                              'Confirm',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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

  orderConfirmedBottomSheet() {
    CartController cartController = Get.find<CartController>();

    return Get.bottomSheet(
      elevation: 5,
      backgroundColor: Colors.white,
      IntrinsicHeight(
        child: Obx(
          () => AnimatedContainer(
              padding: const EdgeInsets.all(10.0),
              duration: Duration(milliseconds: 200),
              child: (cartController.processingOrder.value)
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                          color: primaryColor,
                        )
                      ],
                    )
                  :
                  // (cartController.orderPlaced.value)
                  //     ?
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 20,
                      children: [
                        Center(
                            child: Icon(
                          Icons.done_all,
                          size: 50,
                          color: primaryColor,
                        )),
                        Column(
                          spacing: 10,
                          children: [
                            Text(
                              'Order confirmed!',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelSmall,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'You will receive a call from our staffs soon with the next steps.\nThank you!',
                              style:
                                  AppThemeData.appThemeData.textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                AppController appController =
                                    Get.find<AppController>();

                                appController.navigateDashboard(
                                    id: 0, changeNav: true);

                                Get.back();
                                Get.back();
                              },
                              child: Text(
                                'Continue browsing',
                                style: AppThemeData
                                    .appThemeData.textTheme.labelMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox.shrink()
                      ],
                    )
              // : Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     spacing: 20,
              //     children: [
              //       Center(
              //           child: Icon(
              //         Icons.error_outline,
              //         size: 50,
              //         color: errorColor,
              //       )),
              //       Column(
              //         spacing: 10,
              //         children: [
              //           Text(
              //             "Couldn't place order!",
              //             style: AppThemeData
              //                 .appThemeData.textTheme.labelSmall,
              //             textAlign: TextAlign.center,
              //           ),
              //           Text(
              //             'Something went wrong while placing your order.\nPlease try again later.',
              //             style: AppThemeData
              //                 .appThemeData.textTheme.bodyLarge,
              //             textAlign: TextAlign.center,
              //           ),
              //         ],
              //       ),
              //       Row(
              //         spacing: 10,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           ElevatedButton(
              //             onPressed: () => Get.back(),
              //             child: Text(
              //               'Go back',
              //               style: AppThemeData
              //                   .appThemeData.textTheme.labelMedium!
              //                   .copyWith(color: Colors.white),
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox.shrink()
              //     ],
              //   )
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
