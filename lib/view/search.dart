import 'package:animations/animations.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/view/screens/product_screen.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../controllers/product_controller.dart';
import '../controllers/supabse_controller.dart';
import '../service/app_theme_data.dart';
import '../service/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ProductController productController = Get.find<ProductController>();
  SupabaseController supabaseController = Get.find<SupabaseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              BlurryContainer(
                elevation: 5,
                blur: 1,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                borderRadius: BorderRadius.circular(30),
                child: Center(
                  child: TextFormField(
                    controller: productController.searchField.value,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (q) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'What do you want to find?',
                      labelStyle: AppThemeData
                          .appThemeData.textTheme.bodyMedium!
                          .copyWith(color: Colors.black87),
                      suffixIcon: Icon(
                        Icons.filter_list,
                        color: Colors.black87,
                      ),
                    ),
                    validator: (_) {
                      if (_!.trim().isEmpty) {
                        return 'Please enter your search term';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
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
                      itemCount: productController.allProducts.length,
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
                                              0.6,
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
        ));
  }
}
