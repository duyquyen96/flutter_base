import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprint/common/utils/spacing.dart';
import 'package:sprint/features/home/controllers/home_controller.dart';
import 'package:sprint/features/home/controllers/product_controller.dart';
import 'package:sprint/res/res.dart';
import 'package:sprint/widgets/base_button.dart';
import 'package:sprint/widgets/base_header.dart';

import '../../../res/app_styles.dart';
import '../../../widgets/base_page.dart';
import '../../../widgets/base_text.dart';

class TopTab extends StatefulWidget {
  const TopTab({Key? key}) : super(key: key);

  @override
  State<TopTab> createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {
  // generate dummy data to feed the second SliverGrid
  final List _gridItems = List.generate(90, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('KindaCode.com'),
      //   elevation: 0,
      // ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar #2
          SliverAppBar(
            elevation: 5,
            pinned: true,
            backgroundColor: Colors.pink,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.amber,
                child: const Center(
                    child: Icon(
                  Icons.run_circle,
                  size: 60,
                  color: Colors.white,
                )),
              ),
              title: const Text(
                'Second SliverAppBar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // Just add some padding
          const SliverPadding(padding: EdgeInsets.symmetric(vertical: 20)),

          // SliverGrid #2 (with dynamic content)
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  // generate ambers with random shades
                  color: Colors.amber[Random().nextInt(9) * 100],
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(_gridItems[index]),
                  ),
                );
              },
              childCount: _gridItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
