import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/supabse_controller.dart';
import 'package:toda_app/model/item_model.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/screens/product_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../model/category_model.dart';
import '../service/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SupabaseController supabaseController = Get.find<SupabaseController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        supabaseController.getItems;
        supabaseController.getCategories;
        supabaseController.getOfferItems;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          // top offers section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
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
                          onTap: () => Get.to(() => ProductScreen()),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
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
                                          bottomLeft: Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${offerProducts[index].discount.toStringAsFixed(2)}%',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyMedium!
                                            .copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        offerProducts[index].label,
                                        style: AppThemeData
                                            .appThemeData.textTheme.labelSmall!
                                            .copyWith(color: Colors.black87),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
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
                padding: const EdgeInsets.only(left: 5.0),
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
                          onTap: () => Get.to(() => ProductScreen()),
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
                padding: const EdgeInsets.only(left: 5.0),
                child: Text('All Items',
                    style: AppThemeData.appThemeData.textTheme.labelMedium!),
              ),

              // category chips
              SizedBox(
                height: 40,
                child: StreamBuilder(
                    stream: supabaseController.getCategories,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryLoader();
                          },
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(
                            '>> error getting categories: ${snapshot.error.toString()}');
                        return Text('Error getting categories!');
                      } else if (!snapshot.hasData) {
                        return Text('No categories!');
                      }

                      List<ProductCategory> categories = (snapshot.data!);

                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: FilterChip(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: EdgeInsets.zero,
                                  showCheckmark: true,
                                  label: Text(categories[index].name),
                                  labelStyle: TextStyle(
                                    fontWeight:
                                        categories[index].isSelected.value
                                            ? FontWeight.bold
                                            : null,
                                  ),
                                  selected: categories[index].isSelected.value,
                                  selectedColor: Colors.green,
                                  backgroundColor: Colors.transparent,
                                  checkmarkColor: Colors.teal,
                                  onSelected: (bool value) {
                                    categories[index].isSelected(
                                        !categories[index].isSelected.value);
                                  },
                                ),
                              ));
                        },
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

                    List<Product> items = snapshot.data!;

                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 10, // spacing between rows
                        crossAxisSpacing: 10, // spacing between columns
                      ),
                      padding: EdgeInsets.all(10.0),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.to(() => ProductScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(20)),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 120,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        items[index].label,
                                        style: AppThemeData
                                            .appThemeData.textTheme.labelSmall!
                                            .copyWith(color: Colors.black87),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
          SizedBox.shrink()
        ],
      ),
    );
  }
}
