import 'package:flutter/material.dart';

class ProductGroupListScreen extends StatefulWidget {
  const ProductGroupListScreen({super.key});

  @override
  State<ProductGroupListScreen> createState() => _ProductGroupListScreenState();
}

class _ProductGroupListScreenState extends State<ProductGroupListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
      children: [
        const Placeholder(),
      ],
    ));
  }
}
