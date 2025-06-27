import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/order_controller.dart';
import 'package:toda_app/model/order_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/shimmer_loaders.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.getOrderStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 40,
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: orderController.orderStatusList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => FilterChip(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            padding: EdgeInsets.zero,
                            showCheckmark: true,
                            label: Text(
                                orderController.orderStatusList[index].label),
                            labelStyle: AppThemeData
                                .appThemeData.textTheme.bodyLarge!
                                .copyWith(
                                    color: orderController
                                            .orderStatusList[index]
                                            .isSelected
                                            .value
                                        ? Colors.white
                                        : Colors.black),
                            selected: orderController
                                .orderStatusList[index].isSelected.value,
                            selectedColor: primaryColor,
                            backgroundColor: Colors.transparent,
                            checkmarkColor: Colors.white,
                            onSelected: (bool value) {
                              orderController.orderStatusList[index]
                                  .isSelected(value);

                              for (var group
                                  in orderController.orderStatusList) {
                                if (group !=
                                    orderController.orderStatusList[index]) {
                                  group.isSelected(false);
                                }
                              }

                              orderController.showAll(!value);

                              if (!value) {
                                orderController.activeOrderStatus(-1);
                              } else {
                                orderController.activeOrderStatus(
                                    orderController.orderStatusList[index].id);
                              }
                            }),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      width: 5,
                    ),
                  ),
                ),
              ),
              Obx(
                () => StreamBuilder(
                    stream: (orderController.showAll.value)
                        ? orderController.getOrderHistory
                        : orderController.getFilteredOrderHistory(
                            orderController.activeOrderStatus.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10.0),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return CartLoader();
                          },
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(
                            '>> error getting order history: ${snapshot.error.toString()}');
                        return Text('Error getting order history!');
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Text('No orders!'),
                        );
                      }

                      List<OrderModel> orders = snapshot.data!;

                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10.0),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Obx(
                                  () => SizedBox(
                                    width: 50,
                                    child: (orderController
                                            .fetchingOrderStatusList.value
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : orderStatus(
                                            id: orders[index].status)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order ID: ${orders[index].orderId.toString()}',
                                        style: AppThemeData
                                            .appThemeData.textTheme.labelSmall,
                                      ),
                                      Divider(),
                                      Text(
                                          'Placed in: ${orders[index].createdAt.day.toString()}/${orders[index].createdAt.month.toString()}/${orders[index].createdAt.year.toString()}'),
                                      Text(orders[index].products.length == 1
                                          ? '${orders[index].products.length.toString()} item'
                                          : '${orders[index].products.length.toString()} items'),
                                      Divider(),
                                      Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          'Placed for: ${orders[index].customerName.toString()}\nPhone Number: ${orders[index].phoneNumber.toString()}'),
                                      if (orders[index].completedOn != null)
                                        Text(
                                            'Delivered/Completed on: ${orders[index].completedOn!.day.toString()}/${orders[index].completedOn!.month.toString()}/${orders[index].completedOn!.year.toString()}'),
                                      if (orders[index]
                                          .deliveryLocation
                                          .isNotEmpty)
                                        Text(
                                          'Delivery location: ${orders[index].deliveryLocation.toString()}',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyMedium,
                                      ),
                                      Row(
                                        spacing: 2,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rs.',
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodySmall,
                                          ),
                                          Text(
                                            orders[index]
                                                .totalAmount
                                                .toStringAsFixed(2),
                                            style: AppThemeData.appThemeData
                                                .textTheme.labelSmall,
                                          ),
                                          Text(
                                            '/-',
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Widget orderStatus({required int id}) {
    switch (id) {
      case 1: // order placed
        return Icon(
          Icons.done,
          color: secondaryColor,
        );
      case 2: // order confirmed
        return Icon(
          Icons.fact_check,
          color: secondaryColor,
        );
      case 3: // delivery dispatched
        return Icon(
          Icons.delivery_dining,
          color: secondaryColor,
        );
      case 4: // payment pending
        return Icon(
          Icons.error,
          color: errorColor,
        );
      default: // completed
        return Icon(
          Icons.done_all,
          color: primaryColor,
        );
    }
  }
}
