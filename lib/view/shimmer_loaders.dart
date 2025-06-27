import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';

import '../../service/constants.dart';

// offered products shimmer loader
class OfferProductLoader extends StatefulWidget {
  const OfferProductLoader({super.key});

  @override
  State<OfferProductLoader> createState() => _OfferProductLoaderState();
}

class _OfferProductLoaderState extends State<OfferProductLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.green.shade900,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 150,
        width: 150,
      ),
    );
  }
}

class ProductGroupChipLoader extends StatefulWidget {
  const ProductGroupChipLoader({super.key});

  @override
  State<ProductGroupChipLoader> createState() => _ProductGroupChipLoaderState();
}

class _ProductGroupChipLoaderState extends State<ProductGroupChipLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FilterChip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          padding: EdgeInsets.zero,
          label: Text('category'),
          onSelected: (bool value) {},
        ),
      ),
    );
  }
}

class ProductLoader extends StatefulWidget {
  const ProductLoader({super.key});

  @override
  State<ProductLoader> createState() => _ProductLoaderState();
}

class _ProductLoaderState extends State<ProductLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}

class ProductGroupLoader extends StatefulWidget {
  const ProductGroupLoader({super.key});

  @override
  State<ProductGroupLoader> createState() => _ProductGroupLoaderState();
}

class _ProductGroupLoaderState extends State<ProductGroupLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}

class RecommendedProductLoader extends StatefulWidget {
  const RecommendedProductLoader({super.key});

  @override
  State<RecommendedProductLoader> createState() =>
      _RecommendedProductLoaderState();
}

class _RecommendedProductLoaderState extends State<RecommendedProductLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        child: ListTile(
          title: Text(
            'recommended product',
          ),
          subtitle: Text(
            'manufactured by',
          ),
          trailing: Text(
            'market rate price',
          ),
        ),
      ),
    );
  }
}

// cart product loader
class CartLoader extends StatefulWidget {
  const CartLoader({super.key});

  @override
  State<CartLoader> createState() => _CartLoaderState();
}

class _CartLoaderState extends State<CartLoader> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 90,
        padding: EdgeInsets.only(top: 5, left: 10),
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Text(''),
        //         Text(''),
        //         Row(
        //           spacing: 5,
        //           children: [
        //             Text(''),
        //             Text(''),
        //             Text(''),
        //           ],
        //         ),
        //       ],
        //     ),
        //     Column(
        //       spacing: 10,
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Text(''),
        //         Row(
        //           children: [
        //             Container(
        //               width: 45,
        //               height: 35,
        //               decoration: BoxDecoration(
        //                 // color: errorColor,
        //                 borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(10),
        //                 ),
        //               ),
        //               child: Icon(
        //                 Icons.remove,
        //                 // color: Colors.white,
        //               ),
        //             ),
        //             Container(
        //               width: 45,
        //               height: 35,
        //               decoration: BoxDecoration(
        //                 // color: primaryColor,
        //                 borderRadius:
        //                     BorderRadius.only(bottomRight: Radius.circular(10)),
        //               ),
        //               child: Icon(
        //                 Icons.add,
        //                 // color: Colors.white,
        //               ),
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
