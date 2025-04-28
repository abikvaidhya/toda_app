import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toda_app/model/product_attribute.dart';

Product getProduct(Map<String, dynamic> str) => Product.fromJson(str);

String productJson(Product data) => json.encode(data.toJson());

class Product {
  late final String id, vendor, label, image, manufacturedBy;
  late final double cost, discount, mrp;
  late final int quantity;
  late final List<ProductAttribute> attribute;
  late final bool inStock;
  late final Timestamp expiration, manufacture;

  Product({
    required this.id,
    required this.vendor,
    required this.label,
    required this.image,
    required this.manufacturedBy,
    required this.cost,
    required this.discount,
    required this.mrp,
    required this.attribute,
    required this.inStock,
    required this.expiration,
    required this.manufacture,
    this.quantity = 0,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['description'];
    label = json['name'];
    image = json['image'];
    manufacturedBy = json['manufactured_by'];
    cost = json['cost'];
    discount = json['discount'];
    mrp = json['mrp'];
    attribute = List<ProductAttribute>.from(json['attribute']);
    inStock = json['brand'];
    expiration = json['exp_date'];
    manufacture = json['man_date'];
    quantity = json['qty'];
  }

  factory Product.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final docData = doc.data()!;

    return Product(
      id: doc.id,
      vendor: (docData['vendor'] ?? '').toString(),
      label: (docData['label'] ?? '').toString(),
      image: (docData['image'] ?? '').toString(),
      manufacturedBy: (docData['manufactured_by'] ?? '').toString(),
      cost: double.parse((docData['cost'] ?? 0.0).toString()),
      discount: double.parse((docData['discount'] ?? 0.0).toString()),
      mrp: double.parse((docData['mrp'] ?? 0.0).toString()),
      attribute: (docData['attribute'] as List<dynamic>)
          .map((e) => ProductAttribute.fromJson(e))
          .toList(),
      inStock: docData['in_stock'],
      expiration: (docData['exp_date'] ?? Timestamp.now()),
      manufacture: (docData['man_date'] ?? Timestamp.now()),
      quantity: int.parse(docData['qty'] ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    final product = <String, dynamic>{};
    product['id'] = id;
    product['vendor'] = vendor;
    product['label'] = label;
    product['manufactured_by'] = manufacturedBy;
    product['cost'] = cost;
    product['discount'] = discount;
    product['mrp'] = mrp;
    product['attribute'] = attribute.map((e) => e.toJson()).toList();
    product['in_stock'] = inStock;
    product['man_date'] = manufacture;
    product['qty'] = quantity;

    return product;
  }
}
