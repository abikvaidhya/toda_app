import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/item_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/product_UIs.dart';
import 'package:toda_app/view/screens/product_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../controllers/app_controller.dart';
import '../model/cart_model.dart';
import '../model/category_model.dart';
import '../service/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SupabaseController supabaseController = Get.find<SupabaseController>();
  ProductController productController = Get.find<ProductController>();
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            // top offers section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Obx(() => Text(
                        'Welcome back, ${appController.appUser!.value.displayName ?? ""}',
                        style: AppThemeData.appThemeData.textTheme.bodyLarge,
                      )),
                ),
                if (productController.offerProducts.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text('Top Offers',
                        style: AppThemeData.appThemeData.textTheme.labelMedium),
                  ),
                StreamBuilder(
                  stream: supabaseController.getOfferProducts,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return OfferProductLoader();
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      debugPrint(
                          '>> error getting offer products: ${snapshot.error.toString()}');
                      return Text('Error getting offered products!');
                    } else if (!snapshot.hasData) {
                      return SizedBox.shrink();
                    }

                    // List<Product> offerProducts = (snapshot.data!);
                    productController.offerProducts(snapshot.data);

                    return SizedBox(
                      height: 100,
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: productController.offerProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return OfferProduct(
                                product:
                                    productController.offerProducts[index]);
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),

            // all items section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Browse Products',
                          style:
                              AppThemeData.appThemeData.textTheme.labelMedium!),
                      GestureDetector(
                        onTap: () => appController.navigateDashboard(
                          id: 1,
                          changeNav: true,
                        ),
                        child: Text('View All',
                            style: AppThemeData
                                .appThemeData.textTheme.bodyMedium!
                                .copyWith(
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                ),

                // category chips
                SizedBox(
                  height: 40,
                  child: StreamBuilder(
                      stream: supabaseController.getProductCategories,
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
                                return CategoryLoader();
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          debugPrint(
                              '>> error getting categories: ${snapshot.error.toString()}');
                          return Text('Error getting categories!');
                        } else if (!snapshot.hasData) {
                          return Text('No categories!');
                        }

                        // List<ProductCategory> categories = (snapshot.data!);
                        productController.productCategories(snapshot.data!);

                        return Row(
                          spacing: 5,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => FilterChip(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                padding: EdgeInsets.zero,
                                showCheckmark: true,
                                label: Text(productController.all.name),
                                labelStyle: AppThemeData
                                    .appThemeData.textTheme.bodyLarge!
                                    .copyWith(
                                        color: productController
                                                .all.isSelected.value
                                            ? Colors.white
                                            : Colors.black),
                                selected:
                                    productController.all.isSelected.value,
                                selectedColor: primaryColor,
                                backgroundColor: Colors.transparent,
                                checkmarkColor: Colors.white,
                                onSelected: (bool value) {
                                  productController.all.isSelected(
                                      !productController.all.isSelected.value);
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    productController.productCategories.length,
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
                                              .productCategories[index].name),
                                          labelStyle: AppThemeData
                                              .appThemeData.textTheme.bodyLarge!
                                              .copyWith(
                                                  color: productController
                                                          .productCategories[
                                                              index]
                                                          .isSelected
                                                          .value
                                                      ? Colors.white
                                                      : Colors.black),
                                          selected: productController
                                              .productCategories[index]
                                              .isSelected
                                              .value,
                                          selectedColor: primaryColor,
                                          backgroundColor: Colors.transparent,
                                          checkmarkColor: Colors.white,
                                          onSelected: (bool value) {
                                            productController
                                                .productCategories[index]
                                                .isSelected(!productController
                                                    .productCategories[index]
                                                    .isSelected
                                                    .value);
                                            // supabaseController.allProducts.where((e)=>e.)
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

                // items
                StreamBuilder(
                    stream: supabaseController.getAllProducts,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of items in each row
                            mainAxisSpacing: 10, // spacing between rows
                            crossAxisSpacing: 10, // spacing between columns
                          ),
                          padding: EdgeInsets.all(10.0),
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductLoader();
                          },
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(
                            '>> error getting items: ${snapshot.error.toString()}');
                        return Text('Error getting items!');
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: Text('No items!'),
                        );
                      }

                      // List<Product> items = snapshot.data!;
                      productController.allProducts(snapshot.data!);

                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 10, // spacing between rows
                          crossAxisSpacing: 10, // spacing between columns
                        ),
                        padding: EdgeInsets.all(10.0),
                        itemCount: productController.allProducts.length < 6
                            ? productController.allProducts.length
                            : 6,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Get.to(
                              () => ProductScreen(
                                product: productController.allProducts[index],
                              ),
                              transition: Transition.cupertino,
                            ),
                            child: GridProduct(
                              product: productController.allProducts[index],
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
