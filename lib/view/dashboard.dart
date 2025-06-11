import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/product_UIs.dart';
import 'package:toda_app/view/screens/all_products_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../controllers/app_controller.dart';
import '../model/product_model.dart';

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
          spacing: 10,
          children: [
            // top offers section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Welcome back,',
                    style: AppThemeData.appThemeData.textTheme.bodyLarge,
                  ),
                ),
                if (productController.offerProducts.isNotEmpty)
                  Column(
                    spacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text('Top Offers',
                            style: AppThemeData
                                .appThemeData.textTheme.labelMedium),
                      ),
                      StreamBuilder(
                        stream: supabaseController.getOfferProductStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          );
                        },
                      )
                    ],
                  ),
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
                        onTap: () => Get.to(() => AllProductsScreen()),
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

                // dashboard products
                StreamBuilder(
                    stream: supabaseController.getDashboardProductStream,
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
                      }
                      else if (snapshot.hasError) {
                        debugPrint(
                            '>> error getting items: ${snapshot.error.toString()}');
                        return Text('Error getting items!');
                      }
                      else if (!snapshot.hasData) {
                        return Center(
                          child: Text('No items!'),
                        );
                      }

                      List<Product> products = snapshot.data!;

                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 10, // spacing between rows
                          crossAxisSpacing: 10, // spacing between columns
                        ),
                        padding: EdgeInsets.all(10.0),
                        itemCount: products.length < 10 ? products.length : 10,
                        itemBuilder: (context, index) {
                          return GridProduct(
                            product: products[index],
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
