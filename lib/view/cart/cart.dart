import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/cart/cart_bottom_sheets.dart';
import 'package:toda_app/view/order/order_confirmation_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../../controllers/app_controller.dart';
import '../../service/constants.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        spacing: 10,
        children: [
          SizedBox.shrink(),
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart details:',
                style: AppThemeData.appThemeData.textTheme.labelSmall,
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: cartController.getCartStream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                      itemCount: 5,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          CartLoader());
                } else if (snapshot.hasError) {
                  debugPrint(
                      '>> error getting cart details: ${snapshot.error.toString()}');
                  return Text('Error getting cart details!');
                } else if (!snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Column(
                        spacing: 5,
                        children: [
                          Text(
                            'You have no items in your cart right now.',
                            style:
                                AppThemeData.appThemeData.textTheme.bodyMedium,
                          ),
                          Text(
                            'Add some products on your cart and place your order.',
                            style:
                                AppThemeData.appThemeData.textTheme.labelSmall,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => appController.navigateDashboard(
                            id: 0, changeNav: true),
                        child: Text(
                          'Browse products',
                          style: AppThemeData
                              .appThemeData.textTheme.labelMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }

                return Obx(
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
                                  textAlign: TextAlign.center,
                                  'You have no items in your cart right now.',
                                  style: AppThemeData
                                      .appThemeData.textTheme.bodyMedium,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Add some products on your cart and place your order.',
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelSmall,
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => appController.navigateDashboard(
                                  id: 0, changeNav: true),
                              child: Text(
                                textAlign: TextAlign.center,
                                'Browse products',
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            // cart product list
                            Expanded(
                              child: ListView.builder(
                                itemCount: cartController.cartItems.length,
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Slidable(
                                  endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (v) => cartController
                                              .cartItems
                                              .remove(cartController
                                                  .cartItems[index]),
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )
                                      ]),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 90,
                                    padding: EdgeInsets.only(top: 5, left: 10),
                                    decoration: BoxDecoration(
                                      color: tertiaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  'Item code: ${cartController.cartItems[index].itemCode.toString()}'),
                                              Text(
                                                cartController.cartItems[index]
                                                    .description,
                                                style: AppThemeData.appThemeData
                                                    .textTheme.labelSmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                spacing: 2,
                                                children: [
                                                  Text(
                                                      'Rs.${(cartController.cartItems[index].sp).toStringAsFixed(2)} (per unit)',
                                                      style: AppThemeData
                                                          .appThemeData
                                                          .textTheme
                                                          .bodySmall),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          spacing: 10,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Obx(
                                              () => Text(
                                                  'Rs. ${(cartController.cartItems[index].sp * cartController.cartItems[index].quantity.value).toStringAsFixed(2)}',
                                                  style: AppThemeData
                                                      .appThemeData
                                                      .textTheme
                                                      .bodyMedium),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => cartController
                                                      .removeFromCart(
                                                    product: cartController
                                                        .cartItems[index],
                                                  ),
                                                  child: Container(
                                                    width: 45,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: errorColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.transparent,
                                                  height: 35,
                                                  width: 40,
                                                  child: Center(
                                                    child: Text(
                                                        '${cartController.cartItems[index].quantity}',
                                                        style: AppThemeData
                                                            .appThemeData
                                                            .textTheme
                                                            .labelSmall),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      cartController.addToCart(
                                                    product: cartController
                                                        .cartItems[index],
                                                  ),
                                                  child: Container(
                                                    width: 45,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
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
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),

          // cart submission section
          Obx(
            () => (cartController.fetchingCart.value)
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : (cartController.activeCart.value.items.isEmpty)
                    ? SizedBox.shrink()
                    : Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Text(
                                'Total product count:',
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge,
                              ),
                              Obx(
                                () => Text(
                                  cartController.cartItems.length.toString(),
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Text(
                                'Sum total: Rs.',
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge,
                              ),
                              Obx(
                                () => Text(
                                  cartController.activeCart.value.totalAmount
                                      .toStringAsFixed(2),
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: AppThemeData
                                    .appThemeData.elevatedButtonTheme.style!
                                    .copyWith(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                errorColor)),
                                onPressed: () => CartBottomSheet()
                                    .deleteCartConfirmationBottomSheet(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5,
                                  children: [
                                    Text(
                                      'Clear',
                                      style: AppThemeData
                                          .appThemeData.textTheme.labelMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => OrderConfirmationScreen()),
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
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
