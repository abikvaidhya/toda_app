import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import '../model/category_model.dart';
import '../model/item_model.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> searchField = TextEditingController().obs;
  SupabaseController supabaseController = Get.find<SupabaseController>();

  ProductCategory all = ProductCategory(
    id: 0,
    name: 'All',
    createdAt: DateTime.now(),
    inStock: true,
    isSelected: true.obs,
  );
  RxList<Product> offerProducts = <Product>[].obs,
      allProducts = <Product>[].obs;
  RxList<ProductCategory> productCategories = <ProductCategory>[].obs;

  clearProductCache() {
    offerProducts.clear();
    allProducts.clear();
    productCategories.clear();
  }

  Future getAllProducts() async {
    await supabaseController.getAllProducts
        .toList()
        .then((e) => e.map((product) => Product.fromJson(product)));
    return allProducts;
  }
}
