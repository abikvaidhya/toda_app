import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/product_controller.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/item_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/screens/product_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../controllers/app_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text('Top Offers',
                    style: AppThemeData.appThemeData.textTheme.labelMedium!),
              ),
              StreamBuilder(
                stream: supabaseController.getOfferItems,
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
                    return Center(child: Text('No offered products!'));
                  }

                  List<Product> offerProducts = (snapshot.data!);
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: offerProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.to(
                            () => ProductScreen(),
                            transition: Transition.cupertino,
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(20),
                                  // topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    logo_white,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                            height: 100,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${offerProducts[index].discount.toStringAsFixed(2)}%',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [
                                          0.2,
                                          0.5,
                                          0.7,
                                          0.9,
                                        ],
                                        colors: [
                                          Color.fromARGB(27, 186, 186, 186),
                                          // Color.fromARGB(44, 220, 220, 220),
                                          Color.fromARGB(92, 0, 234, 4),
                                          Color.fromARGB(157, 0, 234, 4),
                                          Color.fromARGB(200, 0, 234, 4),
                                          // Color.fromARGB(102, 11, 11, 11),
                                          // Color.fromARGB(137, 0, 0, 0),
                                          // Color.fromARGB(176, 0, 0, 0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        offerProducts[index].label,
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyLarge!
                                            .copyWith(
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),

          // recommended for you section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Recommended for you',
                    style: AppThemeData.appThemeData.textTheme.labelMedium!),
              ),
              StreamBuilder(
                stream: supabaseController.getItems,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return RecommendedProductLoader();
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

                  List<Product> items = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () => Get.to(
                            () => ProductScreen(),
                            transition: Transition.cupertino,
                          ),
                          selectedColor: Colors.green,
                          style: ListTileStyle.list,
                          leading: Image.asset(
                            logo_white,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            '${items[index].label} (x${items[index].quantity})',
                            style:
                                AppThemeData.appThemeData.textTheme.bodyMedium!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(items[index].manufacturedBy,
                              style: AppThemeData
                                  .appThemeData.textTheme.bodySmall!),
                          trailing: Text(
                              'Rs. ${items[index].mrp.toStringAsFixed(2)}/-',
                              style: AppThemeData
                                  .appThemeData.textTheme.bodyLarge!),
                        ),
                      );
                    },
                  );
                },
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
                      onTap: () {},
                      child: Text('View All',
                          style: AppThemeData.appThemeData.textTheme.bodyMedium!
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
                    stream: supabaseController.getCategories,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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

                      List<ProductCategory> categories = (snapshot.data!);

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
                                      color:
                                          productController.all.isSelected.value
                                              ? Colors.white
                                              : Colors.black),
                              selected: productController.all.isSelected.value,
                              selectedColor: Colors.green,
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
                              itemCount: categories.length,
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
                                        label: Text(categories[index].name),
                                        labelStyle: AppThemeData
                                            .appThemeData.textTheme.bodyLarge!
                                            .copyWith(
                                                color: categories[index]
                                                        .isSelected
                                                        .value
                                                    ? Colors.white
                                                    : Colors.black),
                                        selected:
                                            categories[index].isSelected.value,
                                        selectedColor: Colors.green,
                                        backgroundColor: Colors.transparent,
                                        checkmarkColor: Colors.white,
                                        onSelected: (bool value) {
                                          categories[index].isSelected(
                                              !categories[index]
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
                  stream: supabaseController.getItems,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            () => ProductScreen(),
                            transition: Transition.cupertino,
                          ),
                          child: OpenContainer(
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            openBuilder: (BuildContext context,
                                    void Function({Object? returnValue})
                                        action) =>
                                ProductScreen(),
                            closedBuilder:
                                (BuildContext context, void Function() action) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    logo_white,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [
                                              0.2,
                                              0.5,
                                              0.7,
                                              0.9,
                                            ],
                                            colors: [
                                              Color.fromARGB(44, 220, 220, 220),
                                              Color.fromARGB(92, 0, 234, 4),
                                              Color.fromARGB(157, 0, 234, 4),
                                              Color.fromARGB(200, 0, 234, 4),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              productController
                                                  .allProducts[index].label,
                                              style: AppThemeData.appThemeData
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: Colors.black87),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white70,
                                                    size: 20,
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
          // SizedBox.shrink()
        ],
      ),
    );
  }
}
