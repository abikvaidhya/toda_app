import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/model/item_model.dart';
import '../../service/app_theme_data.dart';
import '../../service/constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.description,
            style: AppThemeData.appThemeData.textTheme.labelMedium!.copyWith(
              color: Colors.white,
            )),
      ),
      body: Container(
        color: primaryColor,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.2,
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white54,
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        logo_white,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      spacing: 5,
                      children: [
                        Divider(
                          endIndent: 20,
                          indent: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Text("Product name:",
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge),
                            Text(widget.product.description,
                                style: AppThemeData
                                    .appThemeData.textTheme.labelSmall),
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
                                    .appThemeData.textTheme.labelLarge!
                                    .copyWith(
                                  color: Colors.black87,
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
      bottomNavigationBar: Obx(
        () => (cartController.cartItems
                    .indexWhere((e) => widget.product.itemCode == e.itemCode) ==
                (-1))
            ? Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          cartController.updateCart(item: widget.product),
                      child: Container(
                        height: 50,
                        color: primaryColor,
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
                      onTap: () => cartController.updateItemQuantity(
                        item: widget.product,
                        remove: true,
                      ),
                      child: Container(
                        height: 50,
                        color: errorColor,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => cartController.updateItemQuantity(
                        item: widget.product,
                      ),
                      child: Container(
                        height: 50,
                        color: primaryColor,
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
