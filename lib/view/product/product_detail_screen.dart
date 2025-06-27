
// product detail section
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/classes/supabase_class.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  CartController cartController = Get.find<CartController>();
  ProductController productController = Get.find<ProductController>();
  SB supabaseController = Get.find<SB>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product detail",
            style: AppThemeData.appThemeData.textTheme.labelMedium!.copyWith(
              color: Colors.white,
            )),
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // product detail section
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  spacing: 20,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: (widget.product.image.isEmpty)
                          ? Image.asset(
                        logo_white,
                        fit: BoxFit.cover,
                        height: 300,
                      )
                          : Image.memory(
                        base64.decode((widget.product.image)),
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                    ),
                    Column(
                      spacing: 5,
                      children: [
                        Divider(
                          endIndent: 5,
                          indent: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("Product name:",
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge),
                            Expanded(
                              child: Text(
                                widget.product.description,
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text("Product price:",
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge),
                            Text("Rs.",
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall),
                            if (widget.product.mrp
                                .isGreaterThan(widget.product.sp))
                              Text(
                                widget.product.mrp.toStringAsFixed(1),
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall!
                                    .copyWith(
                                  color: Colors.black45,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(widget.product.sp.toStringAsFixed(2),
                                style: AppThemeData
                                    .appThemeData.textTheme.labelLarge),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text("Base unit:",
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge),
                            // StreamBuilder(
                            //   stream: supabaseController.getBaseUnitStream,
                            //   builder: (BuildContext context,
                            //       AsyncSnapshot<dynamic> snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return CircularProgressIndicator();
                            //     } else if (snapshot.hasError) {
                            //       debugPrint(
                            //           '>> error getting offer products: ${snapshot.error.toString()}');
                            //       return Text(
                            //           'Error getting offered products!');
                            //     } else if (!snapshot.hasData) {
                            //       return Text("N/A",
                            //           style: AppThemeData
                            //               .appThemeData.textTheme.labelLarge);
                            //     }
                            //
                            //     productController.baseUnits(snapshot.data);
                            //
                            //     return Text(
                            //         productController.baseUnits
                            //             .firstWhere((e) =>
                            //                 e.label == widget.product.baseUnit)
                            //             .label,
                            //         style: AppThemeData
                            //             .appThemeData.textTheme.labelMedium);
                            //   },
                            // ),
                            Text(widget.product.baseUnit,
                                style: AppThemeData
                                    .appThemeData.textTheme.labelMedium)
                          ],
                        ),
                      ],
                    ),
                    Obx(
                          () => ((cartController.cartItems.indexWhere((e) =>
                      widget.product.itemCode == e.itemCode) !=
                          (-1)))
                          ? Column(
                        spacing: 5,
                        children: [
                          Divider(
                            endIndent: 20,
                            indent: 20,
                          ),
                          Text("Product quantity in cart:",
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyLarge),
                          Text(
                              "x${cartController.cartItems.firstWhere((e) => e.itemCode == widget.product.itemCode).quantity.toString()}",
                              style: AppThemeData
                                  .appThemeData.textTheme.labelMedium),
                          Text("Product price on cart:",
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyLarge),
                          if (widget.product.mrp
                              .isGreaterThan(widget.product.sp))
                            Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rs.",
                                    style: AppThemeData.appThemeData
                                        .textTheme.labelSmall),
                                Text(
                                  (widget.product.mrp *
                                      cartController.cartItems
                                          .firstWhere((e) =>
                                      e.itemCode ==
                                          widget.product.itemCode)
                                          .quantity
                                          .value)
                                      .toStringAsFixed(1),
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelLarge!
                                      .copyWith(
                                    color: Colors.black87,
                                    decoration:
                                    TextDecoration.lineThrough,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Rs.",
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelSmall),
                              Text(
                                  (widget.product.sp *
                                      cartController.cartItems
                                          .firstWhere((e) =>
                                      e.itemCode ==
                                          widget.product.itemCode)
                                          .quantity
                                          .value)
                                      .toStringAsFixed(2),
                                  style: AppThemeData
                                      .appThemeData.textTheme.labelLarge),
                            ],
                          ),
                        ],
                      )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Obx(
            () => (cartController.cartItems
            .indexWhere((e) => widget.product.itemCode == e.itemCode) ==
            (-1))
            ? Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    cartController.addToCart(product: widget.product),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      Text('Add to cart',
                          style: AppThemeData
                              .appThemeData.textTheme.labelMedium!
                              .copyWith(
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
            : Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => cartController.removeFromCart(
                  product: widget.product,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: errorColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10))),
                  height: 50,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => cartController.addToCart(
                  product: widget.product,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10))),
                  height: 50,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}