import 'dart:convert';
import 'package:get/get.dart';

Product getProductFromJson(Map<String, dynamic> str) => Product.fromJson(str);

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  late final String description, baseUnit, image;
  late final double itemCode,
      lastCP,
      margin,
      mrp,
      taxableCP,
      sp,
      discountPerc,
      lastPurchasedQuantity,
      stock,
      salesQuantity;
  late final int groupID;
  late RxInt quantity;
  late final bool inStock, offer;

  Product({
    required this.itemCode,
    required this.description,
    required this.baseUnit,
    required this.groupID,
    required this.lastCP,
    required this.taxableCP,
    required this.sp,
    required this.stock,
    required this.lastPurchasedQuantity,
    required this.salesQuantity,
    required this.margin,
    required this.mrp,
    required this.inStock,
    required this.quantity,
    required this.offer,
    required this.discountPerc,
    required this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    itemCode = double.parse(json['item_code'].toString());
    description = json['description'];
    baseUnit = json['base_unit'];
    groupID = json['group_id'];
    lastCP = double.parse((json['last_cp'] ?? 0.0).toString());
    taxableCP = double.parse((json['taxable_cp'] ?? 0.0).toString());
    sp = double.parse(json['sp'].toString());
    stock = double.parse((json['stock'] ?? 0).toString());
    lastPurchasedQuantity =
        double.parse((json['last_purchase_qty'] ?? 0).toString());
    salesQuantity = double.parse((json['sales_qty'] ?? 0).toString());
    margin = double.parse((json['margin'] ?? 0.0).toString());
    mrp = double.parse((json['mrp'] ?? json['sp']).toString());
    inStock = json['in_stock'] ?? true;
    offer = json['offer'] ?? false;
    discountPerc = double.parse((json['discount_perc'] ?? 0).toString());
    quantity = 1.obs;
    image = json['image'] ?? '';
  }

  // factory Product.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final docData = doc.data()!;
  //
  //   return Product(
  //     itemCode: docData['item_code'],
  //     description: docData['description'],
  //     baseUnit: docData['base_unit'],
  //     groupID: docData['group_id'] ?? '',
  //     subGroup: docData['sub_group'] ?? '',
  //     supplierID: docData['supplier'] ?? 0,
  //     lastCP: double.parse(docData['last_cp'].toString()),
  //     taxableCP: double.parse(docData['taxable_cp'].toString()),
  //     sp: double.parse(docData['sp'].toString()),
  //     stock: docData['stock'] ?? 0,
  //     lastPurchasedQuantity: docData['last_purchase_quantity'],
  //     lastPurchasedDate: DateTime.parse(docData['last_purchase_date']),
  //     salesQuantity: int.parse(docData['sales_qty'].toString()),
  //     margin: double.parse(docData['margin'].toString()),
  //     mrp: double.parse(docData['mrp'].toString()),
  //     inStock: docData['in_stock'],
  //     quantity: 1.obs,
  //     offer: docData['offer'],
  //     discountPerc: double.parse((docData['discount_perc'] ?? 0).toString()),
  //     image: docData['image'] ?? '',
  //   );
  // }

  Map<String, dynamic> toJson() {
    final product = <String, dynamic>{};
    product['item_code'] = itemCode;
    product['description'] = description;
    product['base_unit'] = baseUnit;
    product['group_id'] = groupID;
    product['last_cp'] = lastCP;
    product['taxable_cp'] = taxableCP;
    product['sp'] = sp;
    product['stock'] = stock;
    product['last_purchase_quantity'] = lastPurchasedQuantity;
    product['sales_qty'] = salesQuantity;
    product['margin'] = margin;
    product['mrp'] = mrp;
    product['in_stock'] = inStock;
    product['discount_perc'] = discountPerc;
    product['offer'] = offer;

    return product;
  }
}
