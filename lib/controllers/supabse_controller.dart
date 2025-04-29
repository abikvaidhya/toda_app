import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toda_app/model/category_model.dart';
import 'package:toda_app/model/item_model.dart';

class SupabaseController extends GetxController {
  Supabase supabase = Supabase.instance;
  RxBool fetchingItems = true.obs,
      fetchingCategories = true.obs,
      fetchingOffers = true.obs,
      fetchingVendors = true.obs;

  // fetch offer item list
  Stream get getOfferItems => supabase.client
      .from('items')
      .stream(primaryKey: ['id'])
      .eq('offer', true)
      .map((data) => data.map((e) => Product.fromJson(e)).toList());
  // Stream get getOffers =>
  //     supabase.client.from('offers').stream(primaryKey: ['id']).map(
  //             (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch item list
  Stream get getItems =>
      supabase.client.from('items').stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Product.fromJson(e)).toList());

  // fetch category list
  Stream get getCategories =>
      supabase.client.from('categories').stream(primaryKey: ['id']).map(
              (data) => data.map((e) => ProductCategory.fromJson(e)).toList());

  // fetch vendor list
  Stream get getVendors =>
      supabase.client.from('vendors').stream(primaryKey: ['id']).map(
              (data) => data.map((e) => Product.fromJson(e)).toList());
}
