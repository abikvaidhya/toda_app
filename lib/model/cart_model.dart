CartModel getCartFromJson(Map<String, dynamic> str) => CartModel.fromJson(str);

Map<String, dynamic> cartToJson(CartModel data) => data.toJson();

class CartModel {
  late var customerId;

  // late String address, customerName, customerPhoneNumber;
  late Map<String, String> items;
  late DateTime createdAt;
  late double totalAmount;

  // late bool isActive, isDelivery;

  CartModel({
    required this.items,
    required this.customerId,
    required this.totalAmount,
    required this.createdAt,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    items = {
      for (var v in json['items'] ?? [])
        v.toString().split(':')[0]: v.toString().split(':')[1]
    };
    createdAt = DateTime.parse(json['created_at']);
    totalAmount = double.parse(json['total_amount'].toString());
    // address = json['address'] ?? '';
    // customerName = json['customer_name'];
    // customerPhoneNumber = json['customer_phone_number'];
    customerId = json['customer_id'];
    // isActive = json['is_active'];
    // isDelivery = json['is_delivery'];
  }

  Map<String, dynamic> toJson() {
    final cartItem = <String, dynamic>{};
    cartItem['items'] = items.toString();
    cartItem['created_at'] = createdAt.toString();
    cartItem['total_amount'] = totalAmount.toStringAsFixed(2);
    // cartItem['address'] = address.toString();
    // cartItem['customer_name'] = customerName.toString();
    cartItem['customer_id'] = customerId.toString();
    // cartItem['customer_phone_number'] = customerPhoneNumber.toString();
    // cartItem['is_active'] = isActive.toString();
    // cartItem['is_delivery'] = isDelivery.toString();
    return cartItem;
  }
}
