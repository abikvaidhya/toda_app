import 'package:get/get.dart';

OrderStatus getOrderStatusFromJson(Map<String, dynamic> str) =>
    OrderStatus.fromJson(str);

class OrderStatus {
  late int id;
  late String label;
  RxBool isSelected = false.obs;

  OrderStatus(
      {required this.id, required this.label, required this.isSelected});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    label = json["label"];
    isSelected = false.obs;
  }
}
