import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/order_status_model.dart';
import 'package:toda_app/view/ui_utils.dart';
import '../model/base_unit_model.dart';
import '../model/product_group_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  Rx<TextEditingController> searchField = TextEditingController().obs;
  SupabaseController supabaseController = Get.find<SupabaseController>();

  // ProductGroup all = ProductGroup(
  //   id: 0,
  //   name: 'All',
  //   createdAt: DateTime.now(),
  //   image: '',
  //   inStock: true,
  //   isSelected: true.obs,
  // );
  RxBool loadingBaseUnits = true.obs, searchingProducts = false.obs;
  RxList<Product> offeredProducts = <Product>[].obs,
      mainProductList = <Product>[].obs,
      filteredProducts = <Product>[].obs,
      searchedProducts = <Product>[].obs;
  Rx<ProductGroup?> activeProductGroup = null.obs;
  RxList<ProductGroup> productGroup = <ProductGroup>[].obs;
  Rx<TextEditingController> searchQueryController = TextEditingController().obs;
  int start = 0, range = 49;

  @override
  onInit() {
    super.onInit();
    getProducts();
  }

  clearProductCache() {
    offeredProducts.clear();
    mainProductList.clear();
    productGroup.clear();
  }

  getTotalRowCount() {}

  // update range
  loadMoreProducts() {
    start = range;
    range += 49;
  }

  getProducts({bool add = false}) async {
    searchingProducts(true);
    try {
      var temp =
          await supabaseController.getProducts(start: start, range: range);

      if (add) // paginate
      {
        mainProductList
            .addAll((temp as List).map((e) => getProductFromJson(e)).toList());
      } else // load main list
      {
        mainProductList(
            (temp as List).map((e) => getProductFromJson(e)).toList());
      }
    } catch (e) {
      debugPrint('>> error getting products: $e');
    } finally {
      searchingProducts(false);
    }
  }

  // Future getOfferedProducts() async {
  //   var temp = await supabaseController.getProducts;
  //   offeredProducts((temp as List).map((e) => getProductFromJson(e)).toList());
  // }

  applyFilter() async {
    searchingProducts(true);
    searchedProducts.clear();

    try {
      var temp = await supabaseController.getFilteredProducts(
          filter: activeProductGroup.value!.isSelected.value
              ? activeProductGroup.value!.id.toString()
              : null,
          query: searchQueryController.value.text.isNotEmpty
              ? searchQueryController.value.text
              : null);
      filteredProducts(
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

      debugPrint('>> filtered items count: ${filteredProducts.length}');
    }
  }

  Future searchForProduct() async {
    searchingProducts(true);
    searchedProducts.clear();
    try {
      var temp = await supabaseController.searchProducts(
          query: searchQueryController.value.text);
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
