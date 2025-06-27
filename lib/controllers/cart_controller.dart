import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/model/cart_model.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/view/ui_utils.dart';
import 'app_controller.dart';

class CartController extends GetxController {
  SupabaseController supabaseController = SupabaseController.instance;
  AppController appController = Get.find<AppController>();
  UserController userController = Get.find<UserController>();
  ProductController productController = Get.find<ProductController>();
  late Rx<CartModel> activeCart;
  RxList<ProductModel> cartItems = <ProductModel>[].obs;
  RxBool processingCart = false.obs, fetchingCart = false.obs;

  // create new cart instance
  createCart() async {
    activeCart = CartModel(
      items: {},
      totalAmount: 0.0,
      createdAt: DateTime.now(),
      customerId: userController.getUser!.id,
    ).obs;
    updateCartTotal(create: true);
  }

  // get cart details
  getCart() async {
    fetchingCart(true);
    try {
      var data = await getCartData;

      if (data == null) {
        debugPrint('>> creating new cart instance');
        createCart(); // new cart instance
      } else {
        debugPrint('>> got cart instance from db');
        activeCart =
            CartModel.fromJson(data).obs; // retrieved cart instance from database

        cartItems.clear(); // clear cart products

        for (var key in activeCart.value.items.keys) {
          int index = productController.mainProductList
              .indexWhere((product) => product.itemCode == double.parse(key));

          ProductModel cartProduct = productController.mainProductList[index];

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
        createNewCart(
          cart: activeCart.value,
        );
      } else {
        // update cart instance
        debugPrint('>> updating cart database');
        updateCart(
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
      await deleteCart(); // delete cart instance
      getCart(); // create cart instance
    } catch (e) {
      debugPrint('>> error clearing cart in database!: ${e.toString()}');
      UiUtils().showSnackBar(
          title: 'Error', message: 'Could not clear the cart at the moment!');
    } finally {
      processingCart(false);
    }
  }

  // add product to cart
  addToCart({required ProductModel product}) {
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
  removeFromCart({required ProductModel product}) {
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


  // fetch cart items
  Future get getCartData => supabaseController.supabase.client
      .from('cart')
      .select()
      .eq('customer_id', userController.getUser!.id)
      .limit(1)
      .single();

  // stream cart items
  Stream get getCartStream => supabaseController.supabase.client
      .from('cart')
      .stream(primaryKey: ['id'])
      .eq('customer_id', userController.getUser!.id)
      .limit(1)
      .map((data) => data.map((e) => getCartFromJson(e)).toList());

  // create new cart
  Future createNewCart({required CartModel cart}) async => await supabaseController.supabase.client
      .from('cart')
      .insert(cartToJson(cart))
      .catchError((e) => throw e);

  // update cart
  Future updateCart({
    required CartModel cart,
  }) async =>
      await supabaseController.supabase.client
          .from('cart')
          .update({
        'items': cart.items.toString(),
        'total_amount': cart.totalAmount.toStringAsFixed(2),
      })
          .eq('customer_id', cart.customerId)
          .catchError((e) => throw e);

  // delete cart
  Future deleteCart() async => await supabaseController.supabase.client
      .from('cart')
      .delete()
      .eq('customer_id', userController.getUser!.id)
      .catchError((e) => throw e);
}
