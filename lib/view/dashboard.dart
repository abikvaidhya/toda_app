import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toda_app/service/app_theme_data.dart';
import 'package:toda_app/view/screens/product_screen.dart';
import '../service/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        // recommendation section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                top: 10,
              ),
              child: Text('Top Offers',
                  style: AppThemeData.appThemeData.textTheme.labelMedium!),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Get.to(() => ProductScreen()),
                    child: Card(
                      child: Container(
                        width: 150,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 2,
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  logo_white,
                                  fit: BoxFit.contain,
                                  height: 130,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      Text(
                                        '10% off',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodySmall!
                                            .copyWith(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Milk',
                                        style: AppThemeData
                                            .appThemeData.textTheme.bodyMedium!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Rs. ',
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodySmall!),
                                        Text('65.5/-',
                                            style: AppThemeData.appThemeData
                                                .textTheme.bodyLarge!),
                                      ],
                                    )
                                  ],
                                ),
                                Text('DDC',
                                    style: AppThemeData
                                        .appThemeData.textTheme.bodySmall!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // top seller section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text('Recommended for you',
                  style: AppThemeData.appThemeData.textTheme.labelMedium!),
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
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
                      'Cornflakes',
                      style: AppThemeData.appThemeData.textTheme.bodyMedium!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('Kellogs',
                        style: AppThemeData.appThemeData.textTheme.bodySmall!),
                    trailing: Text('Rs. 250.5/-',
                        style: AppThemeData.appThemeData.textTheme.bodyLarge!),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox.shrink()
      ],
    );
  }
}
