import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/cart_model.dart';
import 'package:toda_app/model/product_model.dart';

class CartController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  Rx<Cart?> activeCart = null.obs;
  RxList<Product> cartItems = <Product>[].obs;
  RxDouble mrpTotal = 0.0.obs, costTotal = 0.0.obs;

  // @override
  // onInit() {
  //   super.onInit();
  //
  //   cartItems.listen((e) {
  //     costTotal(0.0);
  //     for (var product in e) {
  //       costTotal.value += product.mrp;
  //     }
  //   });
  // }

  Future getCartItems() async {
    await supabaseController.getCart
        .toList()
        .then((e) => e.map((product) => Cart.fromJson(product)));

    return activeCart;
  }

  updateCart(
      {required Product item,
      bool remove = false,
      bool calculateTotal = true}) {
    if (remove) {
      cartItems.remove(item);
    } else if (cartItems.indexWhere((e) => e.itemCode == item.itemCode) > -1) {
      cartItems.firstWhere((e) => e.itemCode == item.itemCode).quantity++;
    } else {
      cartItems.add(item);
    }

    costTotal(0.0);
    for (var product in cartItems) {
      costTotal.value += (product.sp * product.quantity.value);
    }
  }

  updateItemQuantity({required Product item, bool remove = false}) {
    if (remove) {
      if (cartItems
              .firstWhere((e) => e.itemCode == item.itemCode)
              .quantity
              .value >
          1) {
        cartItems.firstWhere((e) => e.itemCode == item.itemCode).quantity--;
      } else {
        updateCart(item: item, remove: true, calculateTotal: false);
      }
    } else {
      cartItems.firstWhere((e) => e.itemCode == item.itemCode).quantity++;
    }

    costTotal(0.0);
    for (var product in cartItems) {
      costTotal.value += (product.sp * product.quantity.value);
    }
  }
}
