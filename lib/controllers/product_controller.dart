import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/order_model.dart';
import 'package:toda_app/model/order_status_model.dart';
import 'package:toda_app/view/ui_utils.dart';
import '../model/base_unit_model.dart';
import '../model/product_group_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  SupabaseController supabaseController = SupabaseController.instance;

  Rx<TextEditingController> searchField = TextEditingController().obs;
  RxBool loadingBaseUnits = true.obs, searchingProducts = false.obs;
  RxList<ProductModel> offeredProducts = <ProductModel>[].obs,
      mainProductList = <ProductModel>[].obs,
      filteredProducts = <ProductModel>[].obs,
      searchedProducts = <ProductModel>[].obs;
  Rx<ProductGroupModel?> activeProductGroup = null.obs;
  RxList<ProductGroupModel> productGroup = <ProductGroupModel>[].obs;
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
      var temp = await supabaseController.supabase.client.from('products').select().range(start, start + range);

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

  applyFilter() async {
    searchingProducts(true);
    searchedProducts.clear();

    try {
      var temp = await getFilteredProducts(
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
      var temp = await searchProducts(
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

  // fetch dashboard items (16)
  Future get getDashboardProducts =>
      supabaseController.supabase.client.from('products').select().limit(16);

  // stream dashboard items (16)
  Stream get getDashboardProductStream => supabaseController.supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .limit(16)
      .map((data) => data.map((e) => getProductFromJson(e)).toList());

  // get row count of products
  Future get totalRowCount =>
      supabaseController.supabase.client.from('products').select('id').count(CountOption.exact);

  // fetch limited item list (49)
  // Future getProducts({
  //   int start = 0,
  //   int range = 49,
  // }) =>
  //     supabaseController.supabase.client.from('products').select().range(start, start + range);

  // fetch item list with search query
  Future searchProducts({required String query}) =>
      supabaseController.supabase.client.from('products').select().like('description', query);

  // fetch filtered item list with
  Future getFilteredProducts(
          {String? query, String? filter, int start = 0, int range = 49}) =>
      query == null && filter == null
          ? supabaseController.supabase.client
              .from('products')
              .select()
              .range(start, start + range)
          : filter == null && query != null
              ? supabaseController.supabase.client
                  .from('products')
                  .select()
                  .like('description', query)
                  .range(start, start + range)
              : filter != null && query == null
                  ? supabaseController.supabase.client
                      .from('products')
                      .select()
                      .eq('group_id', filter)
                      .range(start, start + range)
                  : supabaseController.supabase.client
                      .from('products')
                      .select()
                      .like('description', query!)
                      .eq('group_id', filter!)
                      .range(start, start + range);

  // stream limited item list
  Stream get getAllProductStream => supabaseController.supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .limit(50)
      .map((data) => data.map((e) => getProductFromJson(e)).toList());

  // fetch offer item list
  Future get getOfferProducts =>
      supabaseController.supabase.client.from('products').select().eq('offer', true);

  // stream offer item list
  Stream get getOfferProductStream => supabaseController.supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .eq('offer', true)
      .map((data) => data.map((e) => getProductFromJson(e)).toList());

  // fetch base units
  Future get getBaseUnits => supabaseController.supabase.client.from('base_units').select();

  // stream base unit
  Stream get getBaseUnitStream =>
      supabaseController.supabase.client.from('base_units').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => getBaseUnitFromJson(e)).toList());
}
