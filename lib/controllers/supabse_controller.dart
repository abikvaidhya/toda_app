import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/model/product_model.dart';

import '../model/base_unit_model.dart';
import '../model/cart_model.dart';

class SupabaseController extends GetxController {
  Supabase supabase = Supabase.instance;
  RxBool fetchingItems = true.obs,
      fetchingCategories = true.obs,
      fetchingOffers = true.obs,
      fetchingVendors = true.obs;

  // late Stream offerProductStream, allProductStream, productCategoryStream;

  // initialize() {
  //   offerProductStream = getOfferProducts;
  //   allProductStream = getAllProducts;
  //   productCategoryStream = getProductCategories;
  // }

  // fetch item list
  Stream get getAllProducts =>
      supabase.client.from('products').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch offer item list
  Stream get getOfferProducts => supabase.client
      .from('products')
      .stream(primaryKey: ['id'])
      .eq('offer', true)
      .map((data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch category list
  Stream get getProductCategories =>
      supabase.client.from('group').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => ProductGroup.fromJson(e)).toList());

  // fetch cart items
  Stream get getBaseUnit =>
      supabase.client.from('base_units').stream(primaryKey: ['id']).map(
              (data) => data.map((e) => BaseUnit.fromJson(e)).toList());

  // fetch vendor list
  Stream get getVendors =>
      supabase.client.from('suppliers').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch cart items
  Stream get getCart =>
      supabase.client.from('cart').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Cart.fromJson(e)).toList());

}
