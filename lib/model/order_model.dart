Order getOrderFromJson(Map<String, dynamic> str) => Order.fromJson(str);

Map<String, dynamic> orderToJson(Order data) => data.toJson();

class Order {
  late var orderId;
  late DateTime createdAt;
  DateTime? completedOn;
  late double totalAmount;
  late int status;
  late var customerId;
  late String phoneNumber, customerName, deliveryLocation;
  late Map<String, String> products;

  Order({
    required this.orderId,
    required this.createdAt,
    required this.completedOn,
    required this.totalAmount,
    required this.status,
    required this.customerId,
    required this.customerName,
    required this.deliveryLocation,
    required this.phoneNumber,
    required this.products,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"];
    createdAt = DateTime.parse(json["created_at"].toString());
    completedOn = json["completed_on"] == null
        ? null
        : DateTime.parse(json["completed_on"].toString());
    totalAmount = double.parse(json["total_amount"].toString());
    status = json["order_status"];
    customerId = json["customer_id"];
    customerName = json["customer_name"];
    deliveryLocation = json["delivery_location"] ?? "";
    phoneNumber = json["customer_phone_number"];
    products = {for (var v in json["products"]) v[0]: v[1]};
  }

  Map<String, dynamic> toJson() {
    final orderModel = <String, dynamic>{};
    orderModel["created_at"] = (createdAt.toString());
    orderModel["completed_on"] = (completedOn.toString());
    orderModel["total_amount"] = totalAmount.toStringAsFixed(2);
    orderModel["order_status"] = status.toString();
    orderModel["customer_id"] = customerId;
    orderModel["customer_name"] = customerName.toString();
    orderModel["delivery_location"] = deliveryLocation.toString();
    orderModel["customer_phone_number"] = phoneNumber.toString();
    orderModel["products"] = products.toString();
    return orderModel;
  }
}
