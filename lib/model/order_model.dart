Order getOrderFromJson(Map<String, dynamic> str) => Order.fromJson(str);

Map<String, dynamic> orderToJson(Order data) => data.toJson();

class Order {
  late var orderId;
  late DateTime createdAt, completedOn;
  late double totalAmount;
  late int status;
  late String customerId, phoneNumber, customerName;
  late Map<String, String> products;

  Order({
    required this.orderId,
    required this.createdAt,
    required this.completedOn,
    required this.totalAmount,
    required this.status,
    required this.customerId,
    required this.customerName,
    required this.phoneNumber,
    required this.products,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"];
    createdAt = json["created_at"];
    completedOn = json["completed_on"];
    totalAmount = json["total_amount"];
    status = json["order_status"];
    customerId = json["customer_id"];
    customerName = json["customer_name"];
    phoneNumber = json["customer_phone_number"];
    products = json["products"];
  }

  Map<String, dynamic> toJson() {
    final orderModel = <String, dynamic>{};
    // orderModel['order_id'] = orderId.toString();
    orderModel["created_at"] = createdAt.toString();
    // orderModel["completed_on"] = (completedOn).toString();
    orderModel["total_amount"] = totalAmount.toStringAsFixed(2);
    orderModel["order_status"] = status.toString();
    orderModel["customer_id"] = customerId.toString();
    orderModel["customer_name"] = customerName.toString();
    orderModel["customer_phone_number"] = phoneNumber.toString();
    orderModel["products"] = products.toString();
    return orderModel;
  }
}
