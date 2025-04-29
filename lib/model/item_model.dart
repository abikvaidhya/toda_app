import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Product getProduct(Map<String, dynamic> str) => Product.fromJson(str);

String productJson(Product data) => json.encode(data.toJson());

class Product {
  late final String vendor, label, image, manufacturedBy;
  late final double cost, discount, mrp, ltr, kg;
  late final int id, quantity, sold, stockPurchased, category;
  late final bool inStock, offer;
  late final DateTime expiration, manufactured;

  Product({
    required this.id,
    required this.label,
    required this.mrp,
    required this.cost,
    required this.discount,
    required this.inStock,
    required this.category,
    required this.expiration,
    required this.manufactured,
    this.offer = false,
    required this.stockPurchased,
    required this.sold,
    this.ltr = 0.0,
    this.kg = 0.0,
    this.manufacturedBy = '',
    this.vendor = '',
    this.image = '',
    this.quantity = 0,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'] ?? '';
    label = json['label'];
    image = json['image'] ?? '';
    manufacturedBy = json['manufacturer'] ?? '';
    cost = double.parse(json['cost'].toString());
    discount = double.parse(json['discount'].toString());
    mrp = double.parse(json['mrp'].toString());
    category = json['category'];
    inStock = json['in_stock'];
    expiration = DateTime.parse(json['expiry_date']);
    manufactured = DateTime.parse(json['man_date']);
    quantity = json['item_quantity'];
    stockPurchased = json['stock_purchased'];
    sold = json['sold'];
  }

  factory Product.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final docData = doc.data()!;

    return Product(
      id: int.parse(doc.id),
      vendor: (docData['vendor'] ?? '').toString(),
      label: (docData['label'] ?? '').toString(),
      image: (docData['image'] ?? '').toString(),
      manufacturedBy: (docData['manufacturer'] ?? '').toString(),
      cost: double.parse((docData['cost'] ?? 0.0).toString()),
      discount: double.parse((docData['discount'] ?? 0.0).toString()),
      mrp: double.parse((docData['mrp'] ?? 0.0).toString()),
      category: docData['category'],
      inStock: docData['in_stock'],
      expiration: (docData['expiry_date'] ?? DateTime.now()),
      manufactured: (docData['man_date'] ?? DateTime.now()),
      quantity: int.parse(docData['item_quantity'] ?? '0'),
      stockPurchased: int.parse(docData['stock_purchased'] ?? '0'),
      sold: int.parse(docData['sold'] ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    final product = <String, dynamic>{};
    product['id'] = id;
    product['vendor'] = vendor;
    product['label'] = label;
    product['manufacturer'] = manufacturedBy;
    product['cost'] = cost;
    product['discount'] = discount;
    product['mrp'] = mrp;
    product['category'] = category;
    product['in_stock'] = inStock;
    product['man_date'] = manufactured;
    product['item_quantity'] = quantity;
    product['stock_purchased'] = stockPurchased;
    product['sold'] = sold;

    return product;
  }
}
