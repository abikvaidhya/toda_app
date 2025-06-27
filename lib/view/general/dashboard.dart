import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/app_controller.dart';
import 'package:toda_app/controllers/cart_controller.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/product_group_controller.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/model/product_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/service/constants.dart';
import 'package:toda_app/view/category/category_screen.dart';
import 'package:toda_app/view/product/product_UIs.dart';
import 'package:toda_app/view/shimmer_loaders.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProductController productController = Get.find<ProductController>();
  ProductGroupController productGroupController =
      Get.find<ProductGroupController>();
  AppController appController = Get.find<AppController>();
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        productController.onInit();
        productGroupController.onInit();
      },
      child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Welcome back,',
                  style: AppThemeData.appThemeData.textTheme.bodyLarge,
                ),
              ),

              // top offers section
              if (productController.offeredProducts.isNotEmpty)
                Column(
                  spacing: 10,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text('Top Offers',
                          style:
                              AppThemeData.appThemeData.textTheme.labelMedium),
                    ),
                    StreamBuilder(
                      stream: productController.getOfferProductStream,
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
                        productController.offeredProducts(snapshot.data);

                        return SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: productController.offeredProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OfferProduct(
                                  product:
                                      productController.offeredProducts[index]);
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),

              // product groups
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories',
                            style: AppThemeData
                                .appThemeData.textTheme.labelMedium!),
                        GestureDetector(
                          onTap: () => Get.to(() => CategoryScreen()),
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

                  // product group list
                  SizedBox(
                    height: 150,
                    child: StreamBuilder(
                        stream: productGroupController.getRandomizedProductGroupStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                return OfferProductLoader();
                              },
                            );
                          } else if (snapshot.hasError) {
                            debugPrint(
                                '>> error getting random product group: ${snapshot.error.toString()}');
                            return Text('Error getting product group!');
                          } else if (!snapshot.hasData) {
                            return Center(
                              child: Text('No product groups!'),
                            );
                          }

                          List<ProductGroupModel> productGroup = snapshot.data!;

                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            itemCount: productGroup.length < 5
                                ? productGroup.length
                                : 5,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      child: SizedBox(
                                        height: 125,
                                        width: 125,
                                        child:
                                            (productGroup[index].image.isEmpty)
                                                ? Image.asset(
                                                    logo_white,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.memory(
                                                    base64.decode(
                                                        (productGroup[index]
                                                            .image)),
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                    Text(
                                      productGroup[index].name,
                                      style: AppThemeData
                                          .appThemeData.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              width: 10,
                            ),
                          );
                        }),
                  ),
                ],
              ),

              // products section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Browse Products',
                            style: AppThemeData
                                .appThemeData.textTheme.labelMedium!),
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

                  // dashboard products
                  StreamBuilder(
                      stream: productController.getDashboardProductStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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

                        List<ProductModel> products = snapshot.data!;

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
                          itemCount:
                              products.length < 10 ? products.length : 10,
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
      ),
    );
  }
}
