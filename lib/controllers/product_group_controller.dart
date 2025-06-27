import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/classes/supabase_class.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/model/product_model.dart';

class ProductGroupController extends GetxController {
  SB supabaseController = SB.instance;
  RxBool loadingProductGroups = true.obs;
  RxList<ProductGroupModel> productGroups = <ProductGroupModel>[].obs;
  Rx<ProductGroupModel?> activeProductGroup = null.obs;

  @override
  onInit() {
    super.onInit();
    fetchProductGroups();
  }

  fetchProductGroups() async {
    loadingProductGroups(true);
    try {
      productGroups(((await getProductGroups) as List)
          .map((e) => getProductGroupFromJson(e))
          .toList());
    } catch (e) {
      debugPrint('>> error getting product groups: $e');
    } finally {
      loadingProductGroups(true);
    }
  }

  // fetch category list
  Future get getProductGroups =>
      supabaseController.supabase.client.from('product_group').select();

  // stream category list
  Stream get getProductGroupStream => supabaseController.supabase.client
      .from('product_group')
      .stream(primaryKey: ['id']).map(
          (data) => data.map((e) => getProductGroupFromJson(e)).toList());

  // stream category list
  Stream get getRandomizedProductGroupStream => supabaseController.supabase.client
      .from('random_product_groups')
      .stream(primaryKey: ['id']).map(
          (data) => data.map((e) => getProductGroupFromJson(e)).toList());
}
