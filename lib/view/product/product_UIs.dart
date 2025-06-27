import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/product/product_detail_screen.dart';

// offered product section
class OfferProduct extends StatefulWidget {
  const OfferProduct({super.key, required this.product});

  final ProductModel product;

  @override
  State<OfferProduct> createState() => _OfferProductState();
}

class _OfferProductState extends State<OfferProduct> {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ProductDetailScreen(
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

  final ProductModel product;

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
              ProductDetailScreen(
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
              // height: 70,
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
                          style: AppThemeData.appThemeData.textTheme.bodySmall,
                          // .copyWith(color: primaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 5,
                          children: [
                            Row(spacing: 2, children: [
                              Text(
                                "Rs.",
                                style: AppThemeData
                                    .appThemeData.textTheme.bodySmall,
                                // !.copyWith(color: tertiaryColor),
                              ),
                              if (widget.product.mrp
                                  .isGreaterThan(widget.product.sp))
                                Text(
                                  widget.product.mrp.toStringAsFixed(1),
                                  style: AppThemeData
                                      .appThemeData.textTheme.bodyLarge!
                                      .copyWith(
                                    // color: tertiaryColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ]),
                            Text(
                              widget.product.sp.toStringAsFixed(2),
                              style: AppThemeData
                                  .appThemeData.textTheme.labelSmall,
                              // .copyWith(color: tertiaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            GestureDetector(
                                onTap: () => cartController.addToCart(
                                    product: widget.product),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
