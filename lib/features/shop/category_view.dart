import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprint/res/res.dart';
import 'package:sprint/widgets/base_header.dart';

import '../../common/utils/spacing.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  // late TabController subTabController = TabController(
  //   length: 3,
  //   vsync: this,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Spacing.height,
        width: Spacing.width,
        child: Column(
          children: [
            const BaseHeader(title: 'title'),
            Expanded(
                child: DefaultTabController(
              length: 10,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    indicatorColor: AppColors.BLACK,
                    tabs: [
                      Tab(text: 'Cây'.tr),
                      Tab(text: 'Chậu'.tr),
                      Tab(text: 'Phụ Kiện'.tr),
                      Tab(text: 'Nền'.tr),
                      Tab(text: 'Nền'.tr),
                      Tab(text: 'Cây'.tr),
                      Tab(text: 'Chậu'.tr),
                      Tab(text: 'Phụ Kiện'.tr),
                      Tab(text: 'Nền'.tr),
                      Tab(text: 'Nền'.tr),
                    ],
                    // controller: tabController,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Icon(Icons.flight, size: 350),
                        Icon(Icons.directions_transit, size: 350),
                        Icon(Icons.directions_car, size: 350),
                        Icon(Icons.directions_bike, size: 350),
                        Icon(Icons.directions_bike, size: 350),
                        Icon(Icons.flight, size: 350),
                        Icon(Icons.directions_transit, size: 350),
                        Icon(Icons.directions_car, size: 350),
                        Icon(Icons.directions_bike, size: 350),
                        Icon(Icons.directions_bike, size: 350),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
