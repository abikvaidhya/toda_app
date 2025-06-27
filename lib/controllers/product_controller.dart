import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/classes/supabase_class.dart';
import 'package:toda_app/view/ui_utils.dart';
import '../model/base_unit_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  SB sb = SB.instance;

  StreamController dashboardProductStreamController = StreamController();

  Rx<TextEditingController> searchField = TextEditingController().obs;
  RxBool loadingDashboardProducts = true.obs,
      loadingBaseUnits = true.obs,
      searchingProducts = false.obs;
  RxList<ProductModel> offeredProducts = <ProductModel>[].obs,
      dashboardProductList = <ProductModel>[].obs,
      mainProductList = <ProductModel>[].obs,
      filteredProducts = <ProductModel>[].obs,
      searchedProducts = <ProductModel>[].obs;
  Rx<TextEditingController> searchQueryController = TextEditingController().obs;
  int start = 0, range = 49;

  @override
  onInit() {
    super.onInit();
    dashboardProductStreamController.sink.add(getDashboardProductStream);

    // fetchDashboardProducts();
    // getProducts();
  }

  // update range
  loadMoreProducts() {
    start = range;
    range += 49;
  }

  fetchDashboardProducts() async {
    loadingDashboardProducts(true);
    try {
      dashboardProductList(((await getDashboardProducts) as List)
          .map((e) => getProductFromJson(e))
          .toList());
    } catch (e) {
      debugPrint('>> error getting dashboard products: $e');
    } finally {
      loadingDashboardProducts(false);
    }
  }

  getProducts({bool add = false}) async {
    searchingProducts(true);
    try {
      var temp = await sb.supabase.client
          .from('product')
          .select()
          .range(start, start + range);

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
      var temp = await searchProducts(query: searchQueryController.value.text);
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
      sb.supabase.client.from('random_20_products').select();

  // stream dashboard items (16)
  Stream get getDashboardProductStream => sb.supabase.client
      .from('random_20_products')
      .stream(primaryKey: ['id']).map(
          (data) => data.map((e) => getProductFromJson(e)).toList());

  // get row count of products
  Future get totalRowCount =>
      sb.supabase.client.from('products').select('id').count(CountOption.exact);

  // fetch limited item list (49)
  // Future getProducts({
  //   int start = 0,
  //   int range = 49,
  // }) =>
  //     supabaseController.supabase.client.from('products').select().range(start, start + range);

  // fetch item list with search query
  Future searchProducts({required String query}) =>
      sb.supabase.client.from('products').select().like('description', query);

  // fetch filtered item list with
  Future getFilteredProducts(
          {String? query, String? filter, int start = 0, int range = 49}) =>
      query == null && filter == null
          ? sb.supabase.client
              .from('product')
              .select()
              .range(start, start + range)
          : filter == null && query != null
              ? sb.supabase.client
                  .from('product')
                  .select()
                  .like('description', query)
                  .range(start, start + range)
              : filter != null && query == null
                  ? sb.supabase.client
                      .from('product')
                      .select()
                      .eq('group_id', filter)
                      .range(start, start + range)
                  : sb.supabase.client
                      .from('product')
                      .select()
                      .like('description', query!)
                      .eq('group_id', filter!)
                      .range(start, start + range);

  // stream limited item list
  Stream get getAllProductStream => sb.supabase.client
      .from('product')
      .stream(primaryKey: ['id'])
      .limit(50)
      .map((data) => data.map((e) => getProductFromJson(e)).toList());

  // fetch offer item list
  Future get getOfferProducts =>
      sb.supabase.client.from('product').select().eq('offer', true);

  // stream offer item list
  Stream get getOfferProductStream => sb.supabase.client
      .from('product')
      .stream(primaryKey: ['id'])
      .eq('offer', true)
      .map((data) => data.map((e) => getProductFromJson(e)).toList());

  // fetch base units
  Future get getBaseUnits => sb.supabase.client.from('base_unit').select();

  // stream base unit
  Stream get getBaseUnitStream =>
      sb.supabase.client.from('base_unit').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => getBaseUnitFromJson(e)).toList());
}
