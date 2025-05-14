import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import '../model/base_unit_model.dart';
import '../model/product_group_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> searchField = TextEditingController().obs;
  SupabaseController supabaseController = Get.find<SupabaseController>();

  ProductGroup all = ProductGroup(
    id: 0,
    name: 'All',
    createdAt: DateTime.now(),
    inStock: true,
    isSelected: true.obs,
  );
  RxBool loadingBaseUnits = true.obs;
  RxList<Product> offerProducts = <Product>[].obs,
      allProducts = <Product>[].obs,
      filteredProducts = <Product>[].obs;
  RxList<ProductGroup> productGroup = <ProductGroup>[].obs;
  RxList<BaseUnit> baseUnits = <BaseUnit>[].obs;

  @override
  onInit() {
    super.onInit();
    getAllProducts();
  }

  clearProductCache() {
    offerProducts.clear();
    allProducts.clear();
    productGroup.clear();
    baseUnits.clear();
  }

  Future getAllProducts() async {
    var temp = await supabaseController.getAllProducts;
    allProducts((temp as List).map((e) => getProductFromJson(e)).toList());
  }
}
