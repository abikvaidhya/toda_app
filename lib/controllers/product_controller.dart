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

  clearProductCache() {
    offerProducts.clear();
    allProducts.clear();
    productGroup.clear();
    baseUnits.clear();
  }

  Future getAllProducts() async {
    allProducts(await supabaseController.getAllProducts);
  }

// Future getBaseUnits() async {
//   loadingBaseUnits(true);
//   try {
//     if (baseUnits.isEmpty) {
//       debugPrint('>> getting base units');
//       debugPrint(supabaseController.getBaseUnit.first.)
//       baseUnits(await supabaseController.getBaseUnit
//           .asyncMap((e) => BaseUnit.fromJson(e))
//           .toList());
//       // baseUnits((await supabaseController.getBaseUnit)
//       //     .toList()
//       //     .map((e) => BaseUnit.fromJson(e))
//       //     .toList());
//     }
//   } catch (e) {
//     baseUnits.clear();
//     debugPrint('>> error getting base units: ${e.toString()}');
//     // UiUtils().showSnackBar(
//     //   title: 'Error',
//     //   message: e.toString(),
//     //   isError: true,
//     // );
//   } finally {
//     loadingBaseUnits(false);
//   }
// }
}
