import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(20),
          ),
        ),
        height: 100,
        width: 200,
      ),
    );
  }
}

class CategoryLoader extends StatefulWidget {
  const CategoryLoader({super.key});

  @override
  State<CategoryLoader> createState() => _CategoryLoaderState();
}

class _CategoryLoaderState extends State<CategoryLoader> {
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
               Radius.circular(15),),
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
