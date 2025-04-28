import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ProductAttribute getProductAttribute(Map<String, dynamic> str) => ProductAttribute.fromJson(str);

String productJson(ProductAttribute data) => json.encode(data.toJson());

class ProductAttribute {
  ProductAttribute({
    required this.id,
    required this.description,
    required this.name,
    required this.price,
    required this.brand,
    required this.gender,
    required this.added,
    this.rating = 0,
    this.reviews = 0,
  });

  late final String id;
  late final String description;
  late final String name;
  late final double price;
  late final String brand;
  late final String gender;
  late final Timestamp added;
  late double rating;
  late int reviews;

  ProductAttribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    brand = json['brand'];
    gender = json['gender'];
    added = json['added'];
  }

  factory ProductAttribute.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final docData = doc.data()!;

    return ProductAttribute(
        id: doc.id,
        description: (docData['description'] ?? '').toString(),
        name: (docData['name'] ?? '').toString(),
        price: double.parse((docData['price'] ?? 0.0).toString()),
        brand: (docData['brand'] ?? '').toString(),
        added: (docData['added'] ?? Timestamp.now()),
        gender: (docData['gender'] ?? '').toString());
  }

  Map<String, dynamic> toJson() {
    final productAttribute = <String, dynamic>{};
    productAttribute['description'] = description;
    productAttribute['name'] = name;
    productAttribute['price'] = price;
    productAttribute['brand'] = brand;
    productAttribute['gender'] = gender;
    productAttribute['added'] = added;

    return productAttribute;
  }
}
