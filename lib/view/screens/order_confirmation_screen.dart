import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/ui_utils.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/supabse_controller.dart';
import '../../service/app_theme_data.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  CartController cartController = Get.find<CartController>();
  SupabaseController supabaseController = Get.find<SupabaseController>();
  var customerInformationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text(
            'Order Confirmation',
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            spacing: 20,
            children: [
              // customer detail form
              Form(
                key: customerInformationKey,
                child: Column(
                  spacing: 10,
                  children: [
                    // customer name
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: primaryColor),
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(25),
                      //   ),
                      //   color: Colors.white70,
                      // ),
                      child: Center(
                        child: TextFormField(
                          controller: cartController.customerName.value,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onFieldSubmitted: (q) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter your name*',
                            labelStyle: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(color: Colors.black87),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                          ),
                          maxLength: 20,
                          validator: (_) {
                            if (_!.trim().isEmpty) {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),

                    // customer phone number
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Center(
                        child: TextFormField(
                          controller: cartController.phoneNumber.value,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (q) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter your phone number*',
                            labelStyle: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(color: Colors.black87),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black87,
                            ),
                          ),
                          maxLength: 10,
                          validator: (_) {
                            if (_!.trim().isEmpty) {
                              return 'Please enter your phone number';
                            } else if (!_.trim().isNumericOnly) {
                              return 'Please enter a valid phone number';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),

                    // customer delivery address
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Center(
                        child: TextFormField(
                          controller: cartController.addressField.value,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.streetAddress,
                          onFieldSubmitted: (q) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter you address for delivery',
                            labelStyle: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(color: Colors.black87),
                            prefixIcon: Icon(
                              Icons.pin_drop,
                              color: Colors.black87,
                            ),
                          ),
                          maxLength: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // cart submission section
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Divider(
                    endIndent: 10,
                    indent: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          color: Colors.white70,
                        ),
                        child: Row(
                          spacing: 2,
                          children: [
                            Text(
                              'Sum total: Rs.',
                              style:
                                  AppThemeData.appThemeData.textTheme.bodyLarge,
                            ),
                            Obx(
                              () => Text(
                                cartController.activeCart.value.totalAmount
                                    .toStringAsFixed(2),
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall!
                                    .copyWith(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (customerInformationKey.currentState!.validate()) {
                            UiUtils().orderConfirmationBottomSheet(
                                phoneNumber:
                                    cartController.phoneNumber.value.text);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text(
                              'Confirm',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
