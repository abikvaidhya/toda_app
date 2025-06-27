import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/view/product/search.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../classes/supabase_class.dart';
import '../../service/constants.dart';


class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  SB supabaseController = Get.find<SB>();
  ProductController productController = Get.find<ProductController>();
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    productController.getProducts();
    productController.filteredProducts(productController.mainProductList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' All Products'),
        ),
        backgroundColor: primaryColor,
        body: Search());
  }
}
