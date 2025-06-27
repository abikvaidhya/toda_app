import 'package:get/get_rx/src/rx_types/rx_types.dart';

ProductGroup getProductGroupFromJson(Map<String, dynamic> str) =>
    ProductGroup.fromJson(str);

class ProductGroup {
  late int id;
  late String name, image;
  late DateTime createdAt;
  late bool inStock;
  RxBool isSelected = false.obs;

  ProductGroup({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.inStock,
    required this.isSelected,
  });

  ProductGroup.fromJson(Map<String, dynamic> json) {
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
