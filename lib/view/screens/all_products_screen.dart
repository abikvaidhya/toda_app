import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/supabse_controller.dart';
import '../../service/app_theme_data.dart';
import '../../service/constants.dart';
import '../product_UIs.dart';
import '../shimmer_loaders.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  ProductController productController = Get.find<ProductController>();
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.filteredProducts(productController.allProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' All Products'),
        ),
        backgroundColor: primaryColor,
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              spacing: 20,
              children: [
                // product group chips
                SizedBox(
                  height: 40,
                  child: StreamBuilder(
                      stream: supabaseController.getProductGroupStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductGroupLoader();
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          debugPrint(
                              '>> error getting product groups: ${snapshot.error.toString()}');
                          return Text('Error getting product groups!');
                        } else if (!snapshot.hasData) {
                          return Text('No product groups!');
                        }

                        productController.productGroup(snapshot.data!);

                        return Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    productController.productGroup.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Obx(() => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: FilterChip(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          padding: EdgeInsets.zero,
                                          showCheckmark: true,
                                          label: Text(productController
                                              .productGroup[index].name),
                                          labelStyle: AppThemeData
                                              .appThemeData.textTheme.bodyLarge!
                                              .copyWith(
                                                  color: productController
                                                          .productGroup[index]
                                                          .isSelected
                                                          .value
                                                      ? Colors.white
                                                      : Colors.black),
                                          selected: productController
                                              .productGroup[index]
                                              .isSelected
                                              .value,
                                          selectedColor: primaryColor,
                                          backgroundColor: Colors.transparent,
                                          checkmarkColor: Colors.white,
                                          onSelected: (bool value) {
                                            for (var group in productController
                                                .productGroup) {
                                              if (group ==
                                                  productController
                                                      .productGroup[index]) {
                                                group.isSelected(value);
                                                productController
                                                    .filteredProducts(
                                                        productController
                                                            .allProducts
                                                            .where((e) =>
                                                                e.groupID ==
                                                                group.id)
                                                            .toList());
                                                if (!value) {
                                                  productController
                                                      .filteredProducts(
                                                          productController
                                                              .allProducts);
                                                }
                                              } else {
                                                group.isSelected(false);
                                              }
                                            }
                                            debugPrint(
                                                '>> filtered items count: ${productController.filteredProducts.length}');
                                          },
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                ),

                // all product section
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => (productController.filteredProducts.isEmpty)
                          ? Center(
                              child: Text('No items found!'),
                            )
                          : GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    2, // number of items for each row
                                mainAxisSpacing: 10, // spacing between rows
                                crossAxisSpacing: 10, // spacing between columns
                              ),
                              padding: EdgeInsets.all(10.0),
                              itemCount:
                                  productController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Get.to(
                                    () => ProductDetail(
                                      product: productController
                                          .filteredProducts[index],
                                    ),
                                    transition: Transition.cupertino,
                                  ),
                                  child: GridProduct(
                                    product: productController
                                        .filteredProducts[index],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
