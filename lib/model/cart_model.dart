import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Cart getReceipt(Map<String, dynamic> str) => Cart.fromJson(str);

String receiptJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.id,
    required this.cart,
    required this.placedIn,
    required this.totalPrice,
    required this.shippingPrice,
    required this.address,
    required this.customerName,
    required this.customerId,
    required this.discountedAmount,
    required this.isActive,
  });

  late final String id;
  late final String address, customerName, customerId;
  late final List<int> cart;
  late final Timestamp placedIn;
  late final double totalPrice, discountedAmount, shippingPrice;
  late final bool isActive;

  Cart.fromJson(Map<String, dynamic> json) {
    id = (json['id']).toString();
    cart = json['cart'];
    placedIn = json['placed_in'];
    totalPrice = json['total_price'];
    shippingPrice = json['shipping_price'];
    address = json['address'];
    customerName = json['customer_name'];
    customerId = json['customer_id'];
    discountedAmount = json['discounted_amount'];
    isActive = json['is_active'];
  }

  factory Cart.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final docData = documentSnapshot.data()!;
    return Cart(
      id: (documentSnapshot.id).toString(),
      cart: (docData['cart'] as List<int>)
          .map((e) => int.parse(e.toString()))
          .toList(),
      placedIn: docData['placed_in'] ?? Timestamp.now(),
      totalPrice: docData['total_price'] ?? 0.0,
      shippingPrice: docData['shipping_price'] ?? 0.0,
      discountedAmount: (docData['discounted_amount'] ?? 0.0),
      address: (docData['address']).toString(),
      isActive: (docData['is_active']),
      customerName: docData['customer_name'],
      customerId: docData['customer_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final cartItem = <String, dynamic>{};
    cartItem['id'] = int.parse(id);
    cartItem['cart'] = cart;
    cartItem['placed_in'] = placedIn;
    cartItem['total_price'] = totalPrice;
    cartItem['shipping_price'] = shippingPrice;
    cartItem['address'] = address;
    cartItem['customer_name'] = customerName;
    cartItem['customer_id'] = customerId;
    cartItem['discounted_amount'] = discountedAmount;
    cartItem['is_active'] = isActive;
    return cartItem;
  }
}
