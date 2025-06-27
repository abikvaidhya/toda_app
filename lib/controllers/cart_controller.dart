import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/cart_model.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/view/ui_utils.dart';
import '../model/order_model.dart';
import 'app_controller.dart';

class CartController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  AppController appController = Get.find<AppController>();
  ProductController productController = Get.find<ProductController>();
  late Rx<Cart> activeCart;
  RxList<Product> cartItems = <Product>[].obs;
  RxBool processingCart = false.obs, fetchingCart = false.obs;

  // create new cart instance
  createCart() async {
    activeCart = Cart(
      items: {},
      totalAmount: 0.0,
      createdAt: DateTime.now(),
      customerId: supabaseController.getUser!.id,
    ).obs;
    updateCartTotal(create: true);
  }

  // get cart details
  getCart() async {
    fetchingCart(true);
    try {
      var data = await supabaseController.getCartData;

      if (data == null) {
        debugPrint('>> creating new cart instance');
        createCart(); // new cart instance
      } else {
        debugPrint('>> got cart instance from db');
        activeCart =
            Cart.fromJson(data).obs; // retrieved cart instance from database

        cartItems.clear(); // clear cart products

        for (var key in activeCart.value.items.keys) {
          int index = productController.mainProductList
              .indexWhere((product) => product.itemCode == double.parse(key));

          Product cartProduct = productController.mainProductList[index];

          cartProduct.quantity(int.parse(activeCart.value.items[key]!));

          if (index != -1) {
            cartItems.add(productController
                .mainProductList[index]); // add cart product from database
          }
        }
      }
    } catch (e) {
      debugPrint('>> error getting cart: $e');
      createCart(); // new cart instance
    } finally {
      fetchingCart(false);
    }
    debugPrint(">> active cart item count: ${activeCart.value.items.length}");
  }

  // update cart total
  updateCartTotal({bool create = false}) {
    double costTotal = 0.0;
    for (var product in cartItems) {
      costTotal += (product.sp *
          product.quantity.value); // calculate total amount for cart products
    }
    activeCart.value.totalAmount = costTotal; // update cart sum total

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
      debugPrint(
          '>> error creating/updating instance of a cart on database: ${e.toString()}');
    } finally {}
  }

  // clear cart
  Future clearCart() async {
    processingCart(true);
    try {
      await supabaseController.deleteCart(); // delete cart instance
      getCart(); // create cart instance
    } catch (e) {
      debugPrint('>> error clearing cart in database!: ${e.toString()}');
      UiUtils().showSnackBar(
          title: 'Error', message: 'Could not clear the cart at the moment!');
    } finally {
      processingCart(false);
    }
  }

  // confirm order
  // Future placeOrder() async {
  //   processingOrder(true);
  //   orderPlaced(false);
  //   try {
  //     activeOrder = Order(
  //       orderId: null,
  //       createdAt: DateTime.now(),
  //       completedOn: DateTime.now(),
  //       totalAmount: activeCart.value.totalAmount,
  //       status: 1,
  //       customerId: supabaseController.getUser!.id,
  //       customerName: customerName.value.text,
  //       phoneNumber: phoneNumber.value.text,
  //       products: activeCart.value.items,
  //     ).obs; // preparing order model for insert in database
  //     await supabaseController.placeOrder(
  //       order: activeOrder.value,
  //     ); //insert order to database
  //
  //     await clearCart(); // clear cart
  //
  //     orderPlaced(true);
  //   } catch (e) {
  //     debugPrint('>> error confirming order: ${e.toString()}');
  //     UiUtils().showSnackBar(
  //         isError: true,
  //         isLong: true,
  //         title: 'Error placing order!',
  //         message: 'Could not confirm your order at the moment!');
  //     orderPlaced(false);
  //   } finally {
  //     processingOrder(false);
  //   }
  // }

  // add product to cart
  addToCart({required Product product}) {
    if (cartItems.indexWhere((e) => e.itemCode == product.itemCode) == -1) {
      debugPrint('>> adding new product to cart');
      cartItems.add(product); // add product to cart
      activeCart.value.items[product.itemCode.toString()] =
          1.toString(); // add product count to active cart
      updateCartTotal();
    } else {
      debugPrint('>> updating product quantity to cart');
      cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity++; // update product count in cart
      activeCart.value.items[product.itemCode.toString()] = cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity
          .value
          .toString(); // update product quantity in cart
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
      debugPrint('>> decreasing product quantity from cart');
      cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity--; // decrease product count in cart
      activeCart.value.items[product.itemCode.toString()] = cartItems
          .firstWhere((e) => e.itemCode == product.itemCode)
          .quantity
          .value
          .toString(); // decrease product quantity in cart
    } else {
      debugPrint('>> removing product from cart');
      cartItems.remove(product); // remove product from cart product list
      activeCart.value.items.remove(
          product.itemCode.toString()); // remove product from active cart
    }
    updateCartTotal();
  }
}
