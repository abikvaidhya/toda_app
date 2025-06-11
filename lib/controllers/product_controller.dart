import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/view/ui_utils.dart';
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
  RxBool loadingBaseUnits = true.obs, searchingProducts = false.obs;
  RxList<Product> offerProducts = <Product>[].obs,
      allProducts = <Product>[].obs,
      filteredProducts = <Product>[].obs,
      searchedProducts = <Product>[].obs;
  RxList<ProductGroup> productGroup = <ProductGroup>[].obs;
  Rx<TextEditingController> searchQueryController = TextEditingController().obs;

  @override
  onInit() {
    super.onInit();
    getAllProducts();
  }

  clearProductCache() {
    offerProducts.clear();
    allProducts.clear();
    productGroup.clear();
    // baseUnits.clear();
  }

  Future getAllProducts() async {
    var temp = await supabaseController.getProducts;
    allProducts((temp as List).map((e) => getProductFromJson(e)).toList());
  }

  Future searchForProduct() async {
    searchingProducts(true);
    searchedProducts.clear();
    try {
      var temp = await supabaseController
          .searchProducts(searchQueryController.value.text);
      searchedProducts(
          (temp as List).map((e) => getProductFromJson(e)).toList());
    } catch (e) {
      searchedProducts.clear();
      debugPrint('>> error fetching items for search query: ${e.toString()}');
      UiUtils().showSnackBar(
          title: 'Error',
          message: 'Could not fetch search results!',
          isError: true);
    } finally {
      searchingProducts(false);
    }
  }
}
