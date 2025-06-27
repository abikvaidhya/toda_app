import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/user_controller.dart';
import 'package:toda_app/model/order_status_model.dart';
import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../view/ui_utils.dart';
import 'supabse_controller.dart';

class OrderController extends GetxController {
  UserController userController = Get.find<UserController>();
  SupabaseController supabaseController = SupabaseController.instance;
  RxBool fetchingOrderStatusList = true.obs,
      processingOrder = true.obs,
      orderPlaced = false.obs,
      showAll = true.obs;
  RxInt activeOrderStatus = (-1).obs;
  late Rx<OrderModel> activeOrder;
  RxList<OrderStatusModel> orderStatusList = <OrderStatusModel>[].obs;
  Rx<TextEditingController> addressField = TextEditingController().obs,
      phoneNumber = TextEditingController().obs,
      customerName = TextEditingController().obs;

  getOrderStatusList() async {
    fetchingOrderStatusList(true);
    try {
      var temp = await supabaseController.supabase.client
          .from('order_status')
          .select();
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
  Future placeOrder({required CartModel activeCart}) async {
    processingOrder(true);
    orderPlaced(false);
    try {
      activeOrder = OrderModel(
        orderId: null,
        createdAt: DateTime.now(),
        completedOn: DateTime.now(),
        totalAmount: activeCart.totalAmount,
        status: 1,
        customerId: userController.getUser!.id,
        customerName: customerName.value.text,
        deliveryLocation: addressField.value.text,
        phoneNumber: phoneNumber.value.text,
        products: activeCart.items,
      ).obs; // preparing order model for insert in database

      await supabaseController.supabase.client
          .from('orders')
          .insert(orderToJson(activeOrder.value))
          .catchError((e) => throw e); // insert order to database

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


  // stream order history
  Stream get getOrderHistory =>
      supabaseController.supabase.client.from('orders').stream(primaryKey: ['order_id'])
      // .eq('order_status', status ?? '')
          .map((data) => data.map((e) => getOrderFromJson(e)).toList());

  // stream filtered order history
  Stream getFilteredOrderHistory(String status) => supabaseController.supabase.client
      .from('orders')
      .stream(primaryKey: ['order_id'])
      .eq('order_status', status)
      .map((data) => data.map((e) => getOrderFromJson(e)).toList());

}
