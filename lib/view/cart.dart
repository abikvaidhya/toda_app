import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import '../controllers/app_controller.dart';
import '../service/constants.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Obx(
          () => (cartController.cartItems.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Column(
                      spacing: 5,
                      children: [
                        Text(
                          'You have no items in your cart right now.',
                          style: AppThemeData.appThemeData.textTheme.bodyMedium,
                        ),
                        Text(
                          'Add some products on your cart and place your order.',
                          style: AppThemeData.appThemeData.textTheme.labelSmall,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => appController.navigateDashboard(
                          id: 0, changeNav: true),
                      child: Text(
                        'Add Products',
                        style: AppThemeData.appThemeData.textTheme.labelSmall!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        SizedBox.shrink(),
                        // header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart details:',
                              style: AppThemeData
                                  .appThemeData.textTheme.labelSmall,
                            ),
                            Row(
                              spacing: 2,
                              children: [
                                Text(
                                  'Rs.',
                                  style: AppThemeData
                                      .appThemeData.textTheme.bodyLarge,
                                ),
                                Obx(
                                  () => Text(
                                    cartController.costTotal.toStringAsFixed(2),
                                    style: AppThemeData
                                        .appThemeData.textTheme.labelSmall,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // cart product list
                        ListView.separated(
                          itemCount: cartController.cartItems.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              Slidable(
                            endActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                onPressed: (v) => cartController.cartItems
                                    .remove(cartController.cartItems[index]),
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            ]),
                            child: Container(
                              height: 90,
                              padding: EdgeInsets.only(top: 5, left: 10),
                              decoration: BoxDecoration(
                                color: tertiaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          'Item code: ${cartController.cartItems[index].itemCode.toString()}'),
                                      Text(
                                          cartController
                                              .cartItems[index].description,
                                          style: AppThemeData.appThemeData
                                              .textTheme.labelMedium),
                                      Row(
                                        spacing: 5,
                                        children: [
                                          Text('Price:',
                                              style: AppThemeData.appThemeData
                                                  .textTheme.bodyLarge),
                                          Text(
                                              'Rs.${(cartController.cartItems[index].sp).toStringAsFixed(2)}',
                                              style: AppThemeData.appThemeData
                                                  .textTheme.labelSmall),
                                          Text(
                                              '(x${cartController.cartItems[index].quantity})',
                                              style: AppThemeData.appThemeData
                                                  .textTheme.labelSmall),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => Text(
                                            'Rs.${(cartController.cartItems[index].sp * cartController.cartItems[index].quantity.value).toStringAsFixed(2)}',
                                            style: AppThemeData.appThemeData
                                                .textTheme.labelSmall),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => cartController
                                                .updateItemQuantity(
                                                    item: cartController
                                                        .cartItems[index],
                                                    remove: true),
                                            child: Container(
                                              width: 45,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: errorColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => cartController
                                                .updateItemQuantity(
                                              item: cartController
                                                  .cartItems[index],
                                            ),
                                            child: Container(
                                              width: 45,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
