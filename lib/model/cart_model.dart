import 'dart:convert';

Cart getReceipt(Map<String, dynamic> str) => Cart.fromJson(str);

String receiptJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.items,
    required this.totalAmount,
    required this.placedIn,
    required this.address,
    required this.customerName,
    required this.customerId,
    required this.customerPhoneNumber,
    required this.isActive,
    required this.isDelivery,
  });

  late var customerId;
  late String address, customerName, customerPhoneNumber;
  late Map items;
  late DateTime placedIn;
  late double totalAmount;
  // late int itemCount;
  late bool isActive, isDelivery;

  Cart.fromJson(Map<String, dynamic> json) {
    items = {
      for (var v in json['items'] ?? [])
        v.toString().split(':')[0]: v.toString().split(':')[1]
    };
    placedIn = DateTime.parse(json['created_at']);
    totalAmount = double.parse(json['total_amount'].toString());
    // itemCount = json['item_count'];
    address = json['address'] ?? '';
    customerName = json['customer_name'];
    customerPhoneNumber = json['customer_phone_number'];
    customerId = json['customer_id'];
    isActive = json['is_active'];
    isDelivery = json['is_delivery'];
  }

  // factory Cart.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
  //   final docData = documentSnapshot.data()!;
  //   return Cart(
  //     id: (documentSnapshot.id).toString(),
  //     cart: (docData['cart'] as List<int>)
  //         .map((e) => int.parse(e.toString()))
  //         .toList(),
  //     placedIn: docData['placed_in'] ?? DateTime.now(),
  //     totalPrice: docData['total_price'] ?? 0.0,
  //     shippingPrice: docData['shipping_price'] ?? 0.0,
  //     discountedAmount: (docData['discounted_amount'] ?? 0.0),
  //     address: (docData['address']).toString(),
  //     isActive: (docData['is_active']),
  //     customerName: docData['customer_name'],
  //     customerId: docData['customer_id'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    final cartItem = <String, dynamic>{};
    cartItem['item'] = items;
    cartItem['created_at'] = placedIn;
    cartItem['total_amount'] = totalAmount;
    // cartItem['item_count'] = itemCount;
    cartItem['address'] = address;
    cartItem['customer_name'] = customerName;
    cartItem['customer_id'] = customerId;
    cartItem['customer_phone_number'] = customerPhoneNumber;
    cartItem['is_active'] = isActive;
    return cartItem;
  }
}
