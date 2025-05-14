OrderStatus getOrderStatusFromJson(Map<String, dynamic> str) =>
    OrderStatus.fromJson(str);

class OrderStatus {
  late int id;
  late String label;

  OrderStatus({
    required this.id,
    required this.label,
  });

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json[""];
    label = json[""];
  }
}
