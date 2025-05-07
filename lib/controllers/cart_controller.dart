import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/cart_model.dart';
import 'package:toda_app/model/product_model.dart';

import 'app_controller.dart';

class CartController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  AppController appController = Get.find<AppController>();
  ProductController productController = Get.find<ProductController>();
  late Rx<Cart> activeCart;
  RxList<Product> cartItems = <Product>[].obs;
  RxDouble mrpTotal = 0.0.obs, costTotal = 0.0.obs;

  @override
  onInit() {
    super.onInit();
    getCart();
  }

  // create new cart instance
  createCart() async {
    activeCart = Cart(
      items: {},
      totalAmount: 0.0,
      placedIn: DateTime.now(),
      address: '',
      customerName: '',
      customerId: supabaseController.getUser!.id,
      customerPhoneNumber: '',
      isActive: true,
      isDelivery: true,
    ).obs;
    updateCartTotal(create: true);
  }

  // get cart details
  getCart() async {
    debugPrint('>> user id: ${supabaseController.getUser!.id}');
    debugPrint('>> user email: ${supabaseController.getUser!.email}');

    try {
      var data = await supabaseController.getCartData;

      activeCart =
          Cart.fromJson(data).obs; // retrieved cart instance from database
    } catch (e) {
      debugPrint('>> error getting cart: $e');
      createCart(); // new cart instance
    }

    cartItems.clear(); // clear cart products

    for (var key in activeCart.value.items.keys) {
      int index = productController.allProducts
          .indexWhere((product) => product.itemCode == int.parse(key));
      Product cartProduct = productController.allProducts[index];
      cartProduct.quantity(int.parse(activeCart.value.items[key]));

      if (index != -1) {
        cartItems.add(productController
            .allProducts[index]); // add cart product from database
      }
    }

    debugPrint(">> active cart item count: ${activeCart.value.items.length}");
    debugPrint(">> cart item count: ${cartItems.length}");
  }

  // update cart total
  updateCartTotal({bool create = false}) {
    costTotal(0.0);
    for (var product in cartItems) {
      costTotal.value += (product.sp *
          product.quantity.value); // calculate total amount for cart products
    }
    activeCart.value.totalAmount = costTotal.value; // update cart sum total

    try {
      if (create) {
        // create new instance of a cart
        debugPrint('>> creating new instance of a cart database');
        supabaseController.createNewCart(
          cart: activeCart.value,
        );
      } else {
        // update cart instance
        debugPrint('>> updating cart database');
        supabaseController.updateCart(
          cart: activeCart.value,
        );
      }
    } catch (e) {
      debugPrint('>> error creating/updating instance of a cart on database: ${e.toString()}');
    } finally {}
  }

  // add product to cart
  addToCart({required Product product}) {
    if (cartItems.indexWhere((e) => e.itemCode == product.itemCode) == -1) {
      cartItems.add(product); // add product to cart
      activeCart.value.items[product.itemCode] =
          1; // add product count to active cart
      updateCartTotal();
    } else {
      cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity++; // update product count in cart
      activeCart.value.items[product.itemCode] = cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity
          .value; // update product quantity in cart
      updateCartTotal();
    }
  }

  // remove product from cart
  removeFromCart({required Product product}) {
    if (cartItems
            .firstWhere((e) => e.itemCode == product.itemCode)
            .quantity
            .value >
        1) {
      cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity--; // decrease product count in cart
      activeCart.value.items[product.itemCode] = cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity
          .value; // decrease product quantity in cart
    } else {
      cartItems.remove(product); // remove product from cart product list
      activeCart.value.items
          .remove(product.itemCode); // remove product from active cart
    }
    updateCartTotal();
  }
}
