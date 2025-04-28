import 'package:flutter/material.dart';

import '../../service/constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.2,
                scale: 1.2,
                image: AssetImage(
                  background_green,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: const Placeholder()));
  }
}
