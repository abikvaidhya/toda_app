import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/category_model.dart';
import '../model/item_model.dart';

class ProductController extends GetxController {
  RxList<Product> allProducts = <Product>[].obs;
  Rx<TextEditingController> searchField = TextEditingController().obs;

  ProductCategory all = ProductCategory(
    id: 0,
    name: 'All',
    createdAt: DateTime.now(),
    inStock: true,
    isSelected: true.obs,
  );
}
