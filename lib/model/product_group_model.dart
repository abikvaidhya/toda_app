import 'package:get/get_rx/src/rx_types/rx_types.dart';

ProductGroupModel getProductGroupFromJson(Map<String, dynamic> str) =>
    ProductGroupModel.fromJson(str);

class ProductGroupModel {
  late int id;
  late String name, image;
  late DateTime createdAt;
  late bool inStock;
  RxBool isSelected = false.obs;

  ProductGroupModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.inStock,
    required this.isSelected,
  });

  ProductGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] ?? '';
    createdAt = DateTime.parse(json['created_at']);
    inStock = json['in_stock'];
    isSelected(false);
  }

  Map<String, dynamic> toJson() {
    final category = <String, dynamic>{};
    category['id'] = id;
    category['name'] = name;
    category['image'] = image;
    category['created_at'] = createdAt;
    category['in_stock'] = inStock;

    return category;
  }
}
