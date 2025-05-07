import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/supabse_controller.dart';
import '../model/product_model.dart';
import '../service/app_theme_data.dart';
import '../service/constants.dart';

// offered product section
class OfferProduct extends StatefulWidget {
  const OfferProduct({super.key, required this.product});

  final Product product;

  @override
  State<OfferProduct> createState() => _OfferProductState();
}

class _OfferProductState extends State<OfferProduct> {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetail(
          product: widget.product,
        ),
        transition: Transition.cupertino,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(20),
              // topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              image: AssetImage(
                logo_white,
              ),
              fit: BoxFit.cover,
            )),
        height: 100,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Text(
                    '${widget.product.discountPerc.toStringAsFixed(2)}%',
                    style: AppThemeData.appThemeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.2,
                      0.5,
                      0.7,
                      0.9,
                    ],
                    colors: [
                      Color.fromARGB(13, 137, 142, 137),
                      Color.fromARGB(81, 39, 69, 39),
                      Color.fromARGB(118, 37, 69, 37),
                      Color.fromARGB(158, 23, 51, 23),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.product.description,
                    style: AppThemeData.appThemeData.textTheme.labelSmall!
                        .copyWith(
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// product grid section
class GridProduct extends StatefulWidget {
  const GridProduct({super.key, required this.product});

  final Product product;

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  ProductController productController = Get.find<ProductController>();
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) =>
              ProductDetail(
        product: widget.product,
      ),
      closedBuilder: (BuildContext context, void Function() action) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: (widget.product.image.isEmpty)
                  ? Image.asset(
                      logo_white,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64.decode((widget.product.image)),
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.2,
                      0.5,
                      0.7,
                      0.9,
                    ],
                    colors: [
                      Color.fromARGB(13, 137, 142, 137),
                      Color.fromARGB(81, 39, 69, 39),
                      Color.fromARGB(118, 37, 69, 37),
                      Color.fromARGB(158, 23, 51, 23),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 0,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.description,
                          style: AppThemeData.appThemeData.textTheme.bodyLarge!
                              .copyWith(color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          spacing: 2,
                          children: [
                            Text(
                              "Rs.",
                            ),
                            if (widget.product.mrp
                                .isGreaterThan(widget.product.sp))
                              Text(
                                widget.product.mrp.toStringAsFixed(1),
                                style: AppThemeData
                                    .appThemeData.textTheme.bodyLarge!
                                    .copyWith(
                                  color: Colors.black87,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(
                              widget.product.sp.toStringAsFixed(2),
                              style: AppThemeData
                                  .appThemeData.textTheme.labelMedium!
                                  .copyWith(color: Colors.black87),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () =>
                          cartController.addToCart(product: widget.product),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: secondaryColor,
                        ),
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                      ))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// product detail section
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CartController cartController = Get.find<CartController>();
  ProductController productController = Get.find<ProductController>();
  SupabaseController supabaseController = Get.find<SupabaseController>();

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

            // product detail section
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white70,
                ),
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
                            StreamBuilder(
                              stream: supabaseController.getBaseUnitStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  debugPrint(
                                      '>> error getting offer products: ${snapshot.error.toString()}');
                                  return Text(
                                      'Error getting offered products!');
                                } else if (!snapshot.hasData) {
                                  return Text("N/A",
                                      style: AppThemeData
                                          .appThemeData.textTheme.labelLarge);
                                }

                                productController.baseUnits(snapshot.data);

                                return Text(
                                    productController.baseUnits
                                        .firstWhere((e) =>
                                            e.code == widget.product.baseUnit)
                                        .label,
                                    style: AppThemeData
                                        .appThemeData.textTheme.labelMedium);
                              },
                            ),
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
