import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/controllers/product_group_controller.dart';
import 'package:toda_app/model/product_group_model.dart';
import 'package:toda_app/view/product/product_UIs.dart';
import 'package:toda_app/view/product/product_detail_screen.dart';
import '../../controllers/product_controller.dart';
import '../../service/app_theme_data.dart';
import '../../service/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ProductController productController = Get.find<ProductController>();
  ProductGroupController productGroupController =
      Get.find<ProductGroupController>();
  Rx<ProductGroupModel?> activeProductGroup = null.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            BlurryContainer(
              elevation: 5,
              blur: 5,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              borderRadius: BorderRadius.circular(30),
              child: Center(
                child: TextFormField(
                  controller: productController.searchField.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (q) => productController.applyFilter(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'What do you want to search for?',
                    labelStyle: AppThemeData.appThemeData.textTheme.bodyMedium!
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

            // product group chips
            // SizedBox(
            //     height: 40,
            //     child: Row(
            //       spacing: 5,
            //       children: [
            //         Expanded(
            //           child: ListView.builder(
            //             shrinkWrap: true,
            //             scrollDirection: Axis.horizontal,
            //             itemCount: productGroupController.productGroups.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Obx(() => Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 5.0),
            //                     child: FilterChip(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.all(
            //                               Radius.circular(25))),
            //                       padding: EdgeInsets.zero,
            //                       showCheckmark: true,
            //                       label: Text(productGroupController
            //                           .productGroups[index].name),
            //                       labelStyle: AppThemeData
            //                           .appThemeData.textTheme.bodyLarge!
            //                           .copyWith(
            //                               color: productGroupController
            //                                       .productGroups[index]
            //                                       .isSelected
            //                                       .value
            //                                   ? Colors.white
            //                                   : Colors.black),
            //                       selected: productGroupController
            //                           .productGroups[index].isSelected.value,
            //                       selectedColor: primaryColor,
            //                       backgroundColor: Colors.transparent,
            //                       checkmarkColor: Colors.white,
            //                       onSelected: (bool value) async {
            //                         productGroupController.productGroups[index]
            //                             .isSelected(value);
            //
            //                         productGroupController.activeProductGroup =
            //                             productGroupController
            //                                 .productGroups[index]
            //                                 .obs; // set active product group filter
            //
            //                         for (var group in productGroupController
            //                             .productGroups) {
            //                           if (group !=
            //                               productGroupController
            //                                   .productGroups[index]) {
            //                             group.isSelected(false);
            //                           }
            //                         }
            //
            //                         await productController.applyFilter();
            //                       },
            //                     ),
            //                   ));
            //             },
            //           ),
            //         ),
            //       ],
            //     )
            //     // StreamBuilder(
            //     //     stream: productGroupController.getProductGroupStream,
            //     //     builder:
            //     //         (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //     //       if (snapshot.connectionState == ConnectionState.waiting) {
            //     //         return Padding(
            //     //           padding: const EdgeInsets.only(left: 10.0),
            //     //           child: ListView.builder(
            //     //             shrinkWrap: true,
            //     //             scrollDirection: Axis.horizontal,
            //     //             itemCount: 7,
            //     //             itemBuilder: (BuildContext context, int index) {
            //     //               return ProductGroupChipLoader();
            //     //             },
            //     //           ),
            //     //         );
            //     //       } else if (snapshot.hasError) {
            //     //         debugPrint(
            //     //             '>> error getting product groups: ${snapshot.error.toString()}');
            //     //         return Text('Error getting product groups!');
            //     //       } else if (!snapshot.hasData) {
            //     //         return Text('No product groups!');
            //     //       }
            //     //
            //     //       productController.productGroup(snapshot.data!);
            //     //
            //     //       return Row(
            //     //         spacing: 5,
            //     //         children: [
            //     //           Expanded(
            //     //             child: ListView.builder(
            //     //               shrinkWrap: true,
            //     //               scrollDirection: Axis.horizontal,
            //     //               itemCount: productController.productGroup.length,
            //     //               itemBuilder: (BuildContext context, int index) {
            //     //                 return Obx(() => Padding(
            //     //                       padding: const EdgeInsets.symmetric(
            //     //                           horizontal: 5.0),
            //     //                       child: FilterChip(
            //     //                         shape: RoundedRectangleBorder(
            //     //                             borderRadius: BorderRadius.all(
            //     //                                 Radius.circular(25))),
            //     //                         padding: EdgeInsets.zero,
            //     //                         showCheckmark: true,
            //     //                         label: Text(productController
            //     //                             .productGroup[index].name),
            //     //                         labelStyle: AppThemeData
            //     //                             .appThemeData.textTheme.bodyLarge!
            //     //                             .copyWith(
            //     //                                 color: productController
            //     //                                         .productGroup[index]
            //     //                                         .isSelected
            //     //                                         .value
            //     //                                     ? Colors.white
            //     //                                     : Colors.black),
            //     //                         selected: productController
            //     //                             .productGroup[index].isSelected.value,
            //     //                         selectedColor: primaryColor,
            //     //                         backgroundColor: Colors.transparent,
            //     //                         checkmarkColor: Colors.white,
            //     //                         onSelected: (bool value) async {
            //     //                           productController.productGroup[index]
            //     //                               .isSelected(value);
            //     //
            //     //                           productController.activeProductGroup =
            //     //                               productController
            //     //                                   .productGroup[index]
            //     //                                   .obs; // set active product group filter
            //     //
            //     //                           for (var group
            //     //                               in productController.productGroup) {
            //     //                             if (group !=
            //     //                                 productController
            //     //                                     .productGroup[index]) {
            //     //                               group.isSelected(false);
            //     //                             }
            //     //                           }
            //     //
            //     //                           await productController.applyFilter();
            //     //                         },
            //     //                       ),
            //     //                     ));
            //     //               },
            //     //             ),
            //     //           ),
            //     //         ],
            //     //       );
            //     //     }),
            //     ),

            // all product section
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => (productController.filteredProducts.isEmpty)
                      ? Center(
                          child: Text('No items found!'),
                        )
                      : (productController.searchingProducts.value)
                          ? Center(
                              child: CircularProgressIndicator(),
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
                                    () => ProductDetailScreen(
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
        ));
  }
}
