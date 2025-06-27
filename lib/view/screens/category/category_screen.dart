import 'package:flutter/material.dart';
import 'package:toda_app/service/app_theme_data.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            // style: AppThemeData.appThemeData.textTheme.bodyLarge,
          ),
        ),
        body: Column(
          children: [
            const Placeholder(),
          ],
        ));
  }
}
