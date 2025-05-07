import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/view/product_UIs.dart';
import 'package:toda_app/view/shimmer_loaders.dart';
import '../controllers/product_controller.dart';
import '../controllers/supabse_controller.dart';
import '../service/app_theme_data.dart';

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
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              // search field
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
                      labelText: 'What do you want to search for?',
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

              // all product section
              GridView.builder(
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
                      () => ProductDetail(
                        product: productController.allProducts[index],
                      ),
                      transition: Transition.cupertino,
                    ),
                    child: GridProduct(
                      product: productController.allProducts[index],
                    ),
                  );
                },
              ),
              // StreamBuilder(
              //     stream: supabaseController.getAllProductStream,
              //     builder:
              //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return GridView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2, // number of items in each row
              //             mainAxisSpacing: 10, // spacing between rows
              //             crossAxisSpacing: 10, // spacing between columns
              //           ),
              //           padding: EdgeInsets.all(10.0),
              //           itemCount: 7,
              //           itemBuilder: (BuildContext context, int index) {
              //             return ProductLoader();
              //           },
              //         );
              //       } else if (snapshot.hasError) {
              //         debugPrint(
              //             '>> error getting items: ${snapshot.error.toString()}');
              //         return Text('Error getting items!');
              //       } else if (!snapshot.hasData) {
              //         return Center(
              //           child: Text('No items!'),
              //         );
              //       }
              //
              //       // List<Product> items = snapshot.data!;
              //       productController.allProducts(snapshot.data!);
              //
              //       return ;
              //     }),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
