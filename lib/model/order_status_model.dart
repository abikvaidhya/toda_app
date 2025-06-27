import 'package:get/get.dart';

OrderStatusModel getOrderStatusFromJson(Map<String, dynamic> str) =>
    OrderStatusModel.fromJson(str);

class OrderStatusModel {
  late int id;
  late String label;
  RxBool isSelected = false.obs;

  OrderStatusModel(
      {required this.id, required this.label, required this.isSelected});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    label = json["label"];
    isSelected = false.obs;
  }
}
