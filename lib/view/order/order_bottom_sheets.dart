import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/order_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';

class OrderBottomSheets{

  orderConfirmationBottomSheet({required String phoneNumber}) {
    CartController cartController = Get.find<CartController>();
    OrderController orderController = Get.find<OrderController>();

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
                    () => (orderController.processingOrder.value)
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
                        await orderController.placeOrder(
                            activeCart: cartController.activeCart.value);
                        Get.back();
                        if (orderController.orderPlaced.value) {
                          cartController.clearCart();
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
    OrderController orderController = Get.find<OrderController>();

    return Get.bottomSheet(
      elevation: 5,
      backgroundColor: Colors.white,
      IntrinsicHeight(
        child: Obx(
              () => AnimatedContainer(
              padding: const EdgeInsets.all(10.0),
              duration: Duration(milliseconds: 200),
              child: (orderController.processingOrder.value)
                  ? Column(
                children: [
                  CircularProgressIndicator(
                    color: primaryColor,
                  )
                ],
              )
                  : Column(
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
                          'Continue browsing',textAlign: TextAlign.center,
                          style: AppThemeData
                              .appThemeData.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox.shrink()
                ],
              )),
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
}