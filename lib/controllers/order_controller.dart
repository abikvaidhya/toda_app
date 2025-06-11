import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/model/order_status_model.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../view/ui_utils.dart';
import 'supabse_controller.dart';

class OrderController extends GetxController {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  RxBool fetchingOrderStatusList = true.obs,
      processingOrder = true.obs,
      orderPlaced = false.obs,
      showAll = true.obs;
  RxInt activeOrderStatus = (-1).obs;
  late Rx<Order> activeOrder;
  RxList<OrderStatus> orderStatusList = <OrderStatus>[].obs;
  Rx<TextEditingController> addressField = TextEditingController().obs,
      phoneNumber = TextEditingController().obs,
      customerName = TextEditingController().obs;

  // late Stream historyListStream;
  // StreamController historyListStreamController = StreamController.broadcast();

  getOrderStatusList() async {
    fetchingOrderStatusList(true);
    try {
      var temp = await supabaseController.getOrderStatus;
      orderStatusList(
          (temp as List).map((e) => getOrderStatusFromJson(e)).toList());
    } catch (e) {
      debugPrint('>> error getting order status: $e');
      orderStatusList.clear();
    } finally {
      fetchingOrderStatusList(false);
    }
  }

  // confirm order
  Future placeOrder({required Cart activeCart}) async {
    processingOrder(true);
    orderPlaced(false);
    try {
      activeOrder = Order(
        orderId: null,
        createdAt: DateTime.now(),
        completedOn: DateTime.now(),
        totalAmount: activeCart.totalAmount,
        status: 1,
        customerId: supabaseController.getUser!.id,
        customerName: customerName.value.text,
        deliveryLocation: addressField.value.text,
        phoneNumber: phoneNumber.value.text,
        products: activeCart.items,
      ).obs; // preparing order model for insert in database

      await supabaseController.placeOrder(
        order: activeOrder.value,
      ); //insert order to database

      orderPlaced(true);
    } catch (e) {
      debugPrint('>> error confirming order: ${e.toString()}');
      UiUtils().showSnackBar(
          isError: true,
          isLong: true,
          title: 'Error placing order!',
          message: 'Could not confirm your order at the moment!');
      orderPlaced(false);
    } finally {
      processingOrder(false);
    }
  }
}
